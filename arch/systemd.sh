#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cat $SCRIPT_DIR/templates/sleep.conf > /etc/systemd/sleep.conf
cat $SCRIPT_DIR/templates/logind.conf > /etc/systemd/logind.conf

systemctl restart systemd-logind.service
