#!/usr/bin/env bash
echo "Configuring EAP instance via setup-eap.cli"
$JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/extensions/setup-eap.cli
