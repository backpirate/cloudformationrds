
#!/bin/bash
set -euo pipefail

DEPLOY_LIST="${1:-}"

if [ -z "$DEPLOY_LIST" ]; then
  echo "No connectors to deploy."
  exit 0
fi

for connector in $DEPLOY_LIST; do
  TEMPLATE_PATH="$connector/template.yaml"
  STACK_NAME="${connector}-stack"

  echo "Deploying stack: $STACK_NAME (template: $TEMPLATE_PATH)"

  if [ ! -f "$TEMPLATE_PATH" ]; then
    echo "ERROR: Template not found: $TEMPLATE_PATH"
    exit 1
  fi

  aws cloudformation deploy \
    --template-file "$TEMPLATE_PATH" \
    --stack-name "$STACK_NAME" \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM

  echo "✅ Deployed $STACK_NAME"
done
