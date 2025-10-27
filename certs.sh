#!/bin/bash
# =====================================================
# Generate self-signed SSL certificate for gitlab.local
# =====================================================

DOMAIN="gitlab.local"
CERT_DIR="./nginx/certs"
DAYS_VALID=825  # kb. 2,25 év

# Create directory if not exists
mkdir -p "$CERT_DIR"

echo "🔧 Generating self-signed certificate for $DOMAIN ..."

# Generate private key and certificate
openssl req -x509 -nodes -days "$DAYS_VALID" -newkey rsa:4096 \
  -keyout "$CERT_DIR/$DOMAIN.key" \
  -out "$CERT_DIR/$DOMAIN.crt" \
  -subj "/C=HU/ST=Budapest/L=Budapest/O=LocalDev/OU=Dev/CN=$DOMAIN"

# Optional: make certificate trusted (Linux: add to system CA store)
echo ""
echo "✅ Certificate generated:"
echo "   Key:  $CERT_DIR/$DOMAIN.key"
echo "   Cert: $CERT_DIR/$DOMAIN.crt"
echo ""
echo "📌 Add to your hosts file if not already done:"
echo "   127.0.0.1  $DOMAIN"
echo ""
echo "💡 You can now access GitLab via: https://$DOMAIN"
