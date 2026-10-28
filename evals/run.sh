#!/usr/bin/env bash
# Prompt-Eval: schickt jeden Testfall aus evals/cases/*.diff mit dem aktuellen
# System-Prompt ans Modell und prüft die Antwort gegen die Regeln in der
# gleichnamigen .expect-Datei. Exit-Code 1, sobald ein Testfall durchfällt.
set -uo pipefail

MODEL="${MODEL:-gemma3:4b}"
OLLAMA_URL="${OLLAMA_URL:-http://localhost:11434}"
PROMPT="${PROMPT:-prompts/review-system.md}"
failed=0

for diff in evals/cases/*.diff; do
  name="$(basename "$diff" .diff)"
  jq -n --rawfile sys "$PROMPT" --rawfile diff "$diff" --arg model "$MODEL" '{
    model: $model, temperature: 0, seed: 42, max_tokens: 400,
    messages: [
      {role: "system", content: $sys},
      {role: "user", content: ("<diff>\n" + $diff + "\n</diff>")}
    ]
  }' > /tmp/eval-request.json

  if ! answer="$(curl -sf --max-time 300 "$OLLAMA_URL/v1/chat/completions" \
        -H "Content-Type: application/json" -d @/tmp/eval-request.json \
        | jq -er '.choices[0].message.content')"; then
    echo "❌ $name: keine Antwort vom Modell"
    failed=1
    continue
  fi

  ok=1
  while IFS= read -r rule; do
    case "$rule" in
      muss:*)  re="${rule#muss:}"; re="${re# }"
               grep -qiE -- "$re" <<<"$answer" || { echo "   fehlt: $re"; ok=0; } ;;
      nicht:*) re="${rule#nicht:}"; re="${re# }"
               ! grep -qiE -- "$re" <<<"$answer" || { echo "   verboten: $re"; ok=0; } ;;
    esac
  done < "evals/cases/$name.expect"

  if [ "$ok" -eq 1 ]; then
    echo "✅ $name"
  else
    echo "❌ $name"
    failed=1
  fi
  { echo "### $name"; echo; echo "$answer"; echo; } >> eval-report.md
done

exit "$failed"
