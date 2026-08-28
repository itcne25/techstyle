# Architecture

## System Architecture

```mermaid
flowchart LR
    User[👤 User] --> Browser[🌐 Web Browser]

    Browser --> Flask[🐍 Flask Application]

    Flask --> Routes[🔀 Routes / API]
    Routes --> Logic[⚙️ Application Logic]
    Logic --> DB[(🗄️ SQLite Database)]

    Flask --> Templates[📄 HTML Templates]
    Templates --> Browser
```

## Application Components

```mermaid
flowchart TB
    subgraph Frontend
        HTML[HTML Templates]
        CSS[CSS]
    end

    subgraph Backend
        Flask[Flask]
        Routes[Routes]
        Logic[Application Logic]
    end

    subgraph Data
        SQLite[(SQLite)]
    end

    HTML --> Flask
    CSS --> HTML
    Flask --> Routes
    Routes --> Logic
    Logic --> SQLite
```

## Development & Deployment

```mermaid
flowchart LR
    Dev[👨‍💻 Developer]
    Git[Git]
    GitHub[GitHub Repository]
    CI[⚙️ CI/CD Pipeline]
    Docker[🐳 Docker Image]
    AWS[☁️ AWS]

    Dev --> Git
    Git --> GitHub
    GitHub --> CI
    CI --> Docker
    Docker --> AWS
```

## Git Workflow

```mermaid
gitGraph
    commit id: "Initial"
    branch feature
    checkout feature
    commit id: "Develop Feature"
    commit id: "Add Tests"
    checkout main
    merge feature id: "Merge PR"
    commit id: "Release v1.0.0" tag: "v1.0.0"
```

## Technology Stack

| Component | Technology |
|---|---|
| Backend | Python / Flask |
| Database | SQLite |
| Frontend | HTML / CSS / JavaScript |
| Version Control | Git / GitHub |
| Testing | Pytest |
| Container | Docker |
| Deployment | AWS |