#!/bin/bash

# ==============================================================================
# Script: simulate_aws_alert.sh
# Descripción: Prueba de Concepto (PoC) para simular una alerta de seguridad de AWS
# mediante SNS, diseñada para ser interceptada por Google Apps Script.
# ==============================================================================

# --- CONFIGURACIÓN ---
# Reemplaza este correo por el que usará el script de Google Workspace
EMAIL_DESTINO="tu_correo@dominio.com"

REGION="us-east-1"
TOPIC_NAME="alertas-seguridad-aws"

# Obtener dinámicamente el Account ID de la cuenta configurada en el CLI
ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
TOPIC_ARN="arn:aws:sns:${REGION}:${ACCOUNT_ID}:${TOPIC_NAME}"

echo "🚀 Iniciando configuración de PoC para alertas de seguridad AWS..."
echo "------------------------------------------------------------------"

# 1. CREAR EL TEMA (TOPIC) SNS
echo "📌 Paso 1: Creando Topic SNS ($TOPIC_NAME) en $REGION..."
aws sns create-topic \
  --name "$TOPIC_NAME" \
  --region "$REGION" > /dev/null

echo "✅ Topic creado: $TOPIC_ARN"
echo ""

# 2. SUSCRIBIR EL CORREO AL TEMA
echo "📌 Paso 2: Suscribiendo el correo $EMAIL_DESTINO al Topic..."
aws sns subscribe \
  --topic-arn "$TOPIC_ARN" \
  --protocol email \
  --notification-endpoint "$EMAIL_DESTINO" \
  --region "$REGION" > /dev/null

echo "⚠️  ACCIÓN REQUERIDA:"
echo "AWS acaba de enviar un correo de confirmación a: $EMAIL_DESTINO"
echo "👉 Ve a la bandeja de entrada y haz clic en 'Confirm subscription'."
read -p "Presiona [ENTER] una vez que hayas confirmado la suscripción para continuar..."

# 3. PUBLICAR EL MENSAJE DE PRUEBA (MOCK)
echo ""
echo "📌 Paso 3: Publicando mensaje de prueba (Mock Alert)..."
aws sns publish \
  --topic-arn "$TOPIC_ARN" \
  --subject "Irregular Activity Detected for Your AWS Access Key - Account $ACCOUNT_ID" \
  --region "$REGION" \
  --message "$(cat <<EOF
Hello,

We have noticed some Irregular Activity in your account.

The following is the list of your affected resource(s):

Access Key: AKIAIOSFODNN7EXAMPLE
IAMUser: hacker-test-user
IP: 198.51.100.24
Event Name: ConsoleLogin

Please review this immediately.
EOF
)" > /dev/null

echo "✅ ¡Mensaje publicado exitosamente!"
echo "Revisa la bandeja de entrada de $EMAIL_DESTINO (y Slack) para verificar si el Apps Script lo procesó correctamente."
