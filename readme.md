# 🚨 AWS Security Alert Simulator (PoC)

Este repositorio contiene un script en Bash para realizar una **Prueba de Concepto (PoC)** que simula notificaciones críticas de seguridad de AWS (específicamente actividad irregular de Access Keys).

El objetivo es validar flujos de automatización de incidentes (por ejemplo: interceptar el correo mediante Google Apps Script y re-enviar alertas formateadas a Slack) sin necesidad de generar una brecha de seguridad real en las cuentas de AWS.

## ⚙️ Prerrequisitos

Antes de ejecutar el script, asegúrate de tener:
1. [AWS CLI](https://aws.amazon.com/cli/) instalado y configurado en tu terminal (`aws configure`).
2. Permisos de IAM suficientes para interactuar con Amazon SNS (`sns:CreateTopic`, `sns:Subscribe`, `sns:Publish`).
3. Permisos de STS (`sts:GetCallerIdentity`) para resolver dinámicamente el ID de la cuenta.

## 🚀 Instalación y Uso

1. **Clona el repositorio** o descarga el script `simulate_aws_alert.sh`.
   ```bash
   git clone <tu-url-del-repo>
   cd <nombre-del-repo>


EMAIL_DESTINO="soporte@tudominio.com"


chmod +x simulate_aws_alert.sh

./simulate_aws_alert.sh
