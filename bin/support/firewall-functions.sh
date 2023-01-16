#!/bin/sh

# utilitiy functions for enabling/disabling
#  - pihole dns blocking
#  - firewall rule that blocks all 17.0.0.0/8 traffic

OPNSENSE_AUTH="${OPNSENSE_API_KEY}":"${OPNSENSE_API_SECRET}"
OPNSENSE_BASE_URL="https://${OPNSENSE_HOST}/api/firewall/filter"
PIHOLE_BASE_URL="http://${PIHOLE_HOST}/admin/api.php?auth=${PIHOLE_API_KEY}"

update_apple_firewall_rule() {
  curl -s -k -u ${OPNSENSE_AUTH} -X POST -d "" \
    "${OPNSENSE_BASE_URL}/toggleRule/${OPNSENSE_APPLE_INGRESS_RULE_UUID}/${1}" \
    > /dev/null

  curl -s -k -u ${OPNSENSE_AUTH} -X POST -d "" \
    "${OPNSENSE_BASE_URL}/toggleRule/${OPNSENSE_APPLE_EGRESS_RULE_UUID}/${1}" \
    > /dev/null
}

apply_firewall_changes() {
  curl -s -k -u ${OPNSENSE_AUTH} -X POST \
    https://${OPNSENSE_HOST}/api/firewall/filter/apply -d "" \
    > /dev/null
}

enable_apple_firewall_rule() {
  update_apple_firewall_rule 1
  apply_firewall_changes
}

disable_apple_firewall_rule() {
  update_apple_firewall_rule 0
  apply_firewall_changes
}

disable_pihole() {
  DISABLE_FOR=${1:-900}

  curl -ks "${PIHOLE_BASE_URL}&disable=${DISABLE_FOR}" > /dev/null
}

enable_pihole() {
  curl -ks "${PIHOLE_BASE_URL}&enable" > /dev/null
}

