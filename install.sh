#!/bin/bash

node install --install Y \
  --isProduction true \
  --rootUrl ${ROOT_URL} \
  --serverPort ${SERVER_PORT} \
  --serverName ${SERVER_NAME} \
  --dbHost adaptdb \
  --dbName adapt-tenant-master \
  --dbPort 27017 \
  --dataRoot data \
  --sessionSecret your-session-secret \
  --useffmpeg Y \
  --smtpService ${SMTP_SERVICE} \
  --smtpUsername ${SMTP_USER} \
  --smtpPassword ${SMTP_PASS} \
  --fromAddress ${SMTP_FROMADDRESS} \
  --name master \
  --displayName Master \
  --email ${ADMIN_EMAIL} \
  --password ${ADMIN_PASSWORD}
  