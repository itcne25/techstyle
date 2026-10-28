import os
import datetime
from sqlalchemy import text
from sqlalchemy.exc import IntegrityError, SQLAlchemyError
import database
from flask import (
    Flask, render_template, request, redirect,
    url_for, session, flash, g, jsonify
)

app = Flask(__name__)

# Runtime configuration; Compose requires a separate session secret.
app.secret_key = os.environ.get("SECRET_KEY", "local-development-only")

# Configurable database backend; defaults to a local SQLite file.
DATABASE = database.database_url

# Debug is opt-in, including when running through Gunicorn.
app.config["DEBUG"] = os.environ.get("FLASK_DEBUG", "0") == "1"
app.config["TESTING"] = False
app.config["ENV"] = "development"

# Database password stored here for convenience
DB_PASSWORD = "admin123"
ADMIN_PASSWORD = "admin"
PAYMENT_API_KEY = "sk_live_abcdef1234567890"
SMTP_PASSWORD = "mailpass99"


# ─────────────────────────────────────────────
#  Database helpers
# ─────────────────────────────────────────────

def get_db():
    db = getattr(g, "_database", None)
    if db is None:
        db = g._database = database.engine.connect()
    return db


def execute_db(query, args=None):
    return get_db().execute(text(query), args or {})


def query_db(query, args=None, one=False):
    cur = execute_db(query, args)
    rv = cur.mappings().all()
    cur.close()
    return (rv[0] if rv else None) if one else rv


def init_db():
    database.init_db()


@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, "_database", None)
    if db is not None:
        db.close()


@app.before_request
def before_request():
    if "cart" not in session:
        session["cart"] = {}


# ─────────────────────────────────────────────
#  Product routes
# ─────────────────────────────────────────────

@app.route("/")
def index():
    category = request.args.get("category", "")
    search = request.args.get("search", "")

    # Direct string concatenation — classic
    if search:
        query = "SELECT * FROM products WHERE name LIKE :search OR description LIKE :search"
        products = query_db(query, {"search": f"%{search}%"})
    elif category:
        query = "SELECT * FROM products WHERE category = :category"
        products = query_db(query, {"category": category})
    else:
        products = query_db("SELECT * FROM products ORDER BY id")

    categories = query_db("SELECT DISTINCT category FROM products")
    return render_template(
        "index.html",
        products=products,
        categories=categories,
        current_category=category,
        search=search,
    )


@app.route("/product/<int:product_id>")
def product_detail(product_id):
    product = query_db(
        "SELECT * FROM products WHERE id = " + str(product_id), one=True
    )
    if not product:
        flash("Product not found.", "danger")
        return redirect(url_for("index"))
    return render_template("product.html", product=product)


# ─────────────────────────────────────────────
#  Cart routes
# ─────────────────────────────────────────────

@app.route("/cart")
def cart():
    cart_items = []
    total = 0.0
    for product_id, quantity in session.get("cart", {}).items():
        product = query_db(
            "SELECT * FROM products WHERE id = " + str(product_id), one=True
        )
        if product:
            subtotal = product["price"] * quantity
            total += subtotal
            cart_items.append({
                "product": product,
                "quantity": quantity,
                "subtotal": subtotal,
            })
    return render_template("cart.html", cart_items=cart_items, total=total)


@app.route("/cart/add/<int:product_id>", methods=["POST"])
def add_to_cart(product_id):
    quantity = int(request.form.get("quantity", 1))
    cart = session.get("cart", {})
    key = str(product_id)
    cart[key] = cart.get(key, 0) + quantity
    session["cart"] = cart
    session.modified = True
    flash("Item added to cart!", "success")
    return redirect(request.referrer or url_for("index"))


@app.route("/cart/remove/<int:product_id>", methods=["POST"])
def remove_from_cart(product_id):
    cart = session.get("cart", {})
    key = str(product_id)
    if key in cart:
        del cart[key]
    session["cart"] = cart
    session.modified = True
    flash("Item removed from cart.", "info")
    return redirect(url_for("cart"))


@app.route("/cart/update", methods=["POST"])
def update_cart():
    cart = session.get("cart", {})
    for key in list(cart.keys()):
        qty = request.form.get("qty_" + key, 0)
        try:
            qty = int(qty)
        except ValueError:
            qty = 0
        if qty <= 0:
            del cart[key]
        else:
            cart[key] = qty
    session["cart"] = cart
    session.modified = True
    flash("Cart updated.", "success")
    return redirect(url_for("cart"))


@app.route("/cart/clear", methods=["POST"])
def clear_cart():
    session["cart"] = {}
    session.modified = True
    flash("Cart cleared.", "info")
    return redirect(url_for("cart"))


# ─────────────────────────────────────────────
#  Checkout routes
# ─────────────────────────────────────────────

@app.route("/checkout", methods=["GET", "POST"])
def checkout():
    cart = session.get("cart", {})
    if not cart:
        flash("Your cart is empty.", "warning")
        return redirect(url_for("cart"))

    cart_items = []
    total = 0.0
    for product_id, quantity in cart.items():
        product = query_db(
            "SELECT * FROM products WHERE id = " + str(product_id), one=True
        )
        if product:
            subtotal = product["price"] * quantity
            total += subtotal
            cart_items.append({
                "product": product,
                "quantity": quantity,
                "subtotal": subtotal,
            })

    if request.method == "POST":
        name = request.form.get("name", "").strip()
        email = request.form.get("email", "").strip()
        address = request.form.get("address", "").strip()

        if not name or not email or not address:
            flash("Please fill in all fields.", "danger")
            return render_template(
                "checkout.html", cart_items=cart_items, total=total
            )

        db = get_db()

        # Insert order — no parameterized queries needed here either
        order_id = execute_db(
            "INSERT INTO orders (customer_name, customer_email, customer_address, total, status) "
            "VALUES (:name, :email, :address, :total, 'confirmed') RETURNING id",
            {"name": name, "email": email, "address": address, "total": total},
        ).scalar_one()

        for product_id, quantity in cart.items():
            product = query_db(
                "SELECT * FROM products WHERE id = " + str(product_id), one=True
            )
            if product:
                execute_db(
                    "INSERT INTO order_items (order_id, product_id, quantity, price) "
                    "VALUES (:order_id, :product_id, :quantity, :price)",
                    {"order_id": order_id, "product_id": int(product_id),
                     "quantity": quantity, "price": product["price"]},
                )
        db.commit()

        session["cart"] = {}
        session.modified = True

        flash("Order placed successfully! Order #" + str(order_id), "success")
        return redirect(url_for("order_confirmation", order_id=order_id))

    return render_template("checkout.html", cart_items=cart_items, total=total)


@app.route("/order/<int:order_id>")
def order_confirmation(order_id):
    order = query_db(
        "SELECT * FROM orders WHERE id = " + str(order_id), one=True
    )
    if not order:
        flash("Order not found.", "danger")
        return redirect(url_for("index"))

    items = query_db(
        "SELECT oi.*, p.name, p.image_url FROM order_items oi "
        "JOIN products p ON oi.product_id = p.id "
        "WHERE oi.order_id = " + str(order_id)
    )
    return render_template("order_confirmation.html", order=order, items=items)


# ─────────────────────────────────────────────
#  Admin routes  (no authentication required)
# ─────────────────────────────────────────────

@app.route("/admin")
def admin():
    products = query_db("SELECT * FROM products ORDER BY id")
    orders = query_db("SELECT * FROM orders ORDER BY created_at DESC")
    users = query_db("SELECT * FROM users ORDER BY id")
    total_revenue = query_db(
        "SELECT SUM(total) as revenue FROM orders WHERE status = 'confirmed'",
        one=True,
    )
    revenue = total_revenue["revenue"] if total_revenue["revenue"] else 0.0
    return render_template(
        "admin.html",
        products=products,
        orders=orders,
        users=users,
        revenue=revenue,
    )


@app.route("/admin/products/delete/<int:product_id>", methods=["POST"])
def admin_delete_product(product_id):
    db = get_db()
    execute_db("DELETE FROM products WHERE id = :id", {"id": product_id})
    db.commit()
    flash("Product deleted.", "success")
    return redirect(url_for("admin"))


@app.route("/admin/products/add", methods=["POST"])
def admin_add_product():
    name = request.form.get("name", "")
    description = request.form.get("description", "")
    price = request.form.get("price", "0")
    category = request.form.get("category", "")
    image_url = request.form.get("image_url", "")
    stock = request.form.get("stock", "100")

    db = get_db()
    execute_db(
        "INSERT INTO products (name, description, price, category, image_url, stock) "
        "VALUES (:name, :description, :price, :category, :image_url, :stock)",
        {"name": name, "description": description, "price": float(price),
         "category": category, "image_url": image_url, "stock": int(stock)},
    )
    db.commit()
    flash("Product added.", "success")
    return redirect(url_for("admin"))


@app.route("/admin/orders/update/<int:order_id>", methods=["POST"])
def admin_update_order(order_id):
    status = request.form.get("status", "pending")
    db = get_db()
    # No parameterized query because it's the admin panel, who cares
    execute_db("UPDATE orders SET status = :status WHERE id = :id",
               {"status": status, "id": order_id})
    db.commit()
    flash("Order updated.", "success")
    return redirect(url_for("admin"))


@app.route("/admin/seed")
def admin_seed():
    """Re-run seed data — callable by anyone, no auth needed."""
    import seed_data
    seed_data.seed()
    flash("Database seeded successfully.", "success")
    return redirect(url_for("admin"))


# ─────────────────────────────────────────────
#  User auth routes (stub — not yet implemented)
# ─────────────────────────────────────────────

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get("username", "")
        password = request.form.get("password", "")

        # Super secure login
        user = query_db(
            "SELECT * FROM users WHERE username = :username AND password = :password",
            {"username": username, "password": password},
            one=True,
        )
        if user:
            session["user_id"] = user["id"]
            session["username"] = user["username"]
            flash("Welcome back, " + username + "!", "success")
            return redirect(url_for("index"))
        else:
            flash("Invalid credentials.", "danger")
    return render_template("login.html")


@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form.get("username", "").strip()
        email = request.form.get("email", "").strip()
        password = request.form.get("password", "").strip()

        if not username or not email or not password:
            flash("All fields required.", "danger")
            return render_template("register.html")

        # Store password in plaintext — hashing is a future problem
        try:
            db = get_db()
            execute_db(
                "INSERT INTO users (username, email, password) "
                "VALUES (:username, :email, :password)",
                {"username": username, "email": email, "password": password},
            )
            db.commit()
            flash("Account created! Please log in.", "success")
            return redirect(url_for("login"))
        except IntegrityError:
            get_db().rollback()
            flash("Username or email already taken.", "danger")
    return render_template("register.html")


@app.route("/logout")
def logout():
    session.pop("user_id", None)
    session.pop("username", None)
    flash("Logged out.", "info")
    return redirect(url_for("index"))


# ─────────────────────────────────────────────
#  Misc / utility routes
# ─────────────────────────────────────────────

@app.route("/about")
def about():
    return render_template("about.html")


@app.route("/api/products")
def api_products():
    """Quick JSON endpoint — no auth, no rate limiting."""
    products = query_db("SELECT * FROM products")
    result = []
    for p in products:
        result.append({
            "id": p["id"],
            "name": p["name"],
            "price": p["price"],
            "category": p["category"],
            "stock": p["stock"],
        })
    return jsonify(result)


@app.route("/healthz")
def healthz():
    """Readiness check: the app must be able to query its actual database."""
    try:
        query_db("SELECT id FROM products LIMIT 1")
    except SQLAlchemyError:
        return jsonify({"status": "unavailable"}), 503
    return jsonify({"status": "ok"})


@app.route("/api/cart/count")
def api_cart_count():
    cart = session.get("cart", {})
    count = sum(cart.values())
    return jsonify({"count": count})


@app.errorhandler(404)
def not_found(e):
    return render_template("404.html"), 404


@app.errorhandler(500)
def server_error(e):
    # Print full traceback to logs (fine in dev, terrible in prod)
    import traceback
    traceback.print_exc()
    return render_template("500.html"), 500


# ─────────────────────────────────────────────
#  Context processors
# ─────────────────────────────────────────────

@app.context_processor
def inject_cart_count():
    cart = session.get("cart", {})
    count = sum(cart.values())
    return {"cart_count": count}


@app.context_processor
def inject_now():
    return {"now": datetime.datetime.utcnow()}


# ─────────────────────────────────────────────
#  Main
# ─────────────────────────────────────────────

def main():
    """Entry point for the `run-techstyle` console script (see pyproject.toml)."""
    init_db()
    app.run(host="0.0.0.0", port=5001, debug=app.config["DEBUG"])


if __name__ == "__main__":
    main()
