#!/bin/bash

node install --install Y \
    --serverPort 5000 \
    --serverName localhost \
    --dbHost adaptdb \
    --dbName adapt-tenant-master \
    --dbPort 27017 \
    --dataRoot data \
    --sessionSecret your-session-secret \
    --useffmpeg Y \
    --smtpService dummy \
    --smtpUsername smtpUser \
    --smtpPassword smtpPass \
    --fromAddress you@example.com \
    --name master \
    --displayName Master \
    --email ${ADMIN_EMAIL} \
    --password ${ADMIN_PASSWORD}
    # && node upgrade --Y/n Y