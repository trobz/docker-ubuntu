
# load additional bash scripts
if [ -d /etc/bash.d ]; then
  for i in /etc/bash.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

# For commandline tools
export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
