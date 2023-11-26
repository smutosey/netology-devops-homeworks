#!/bin/bash
docker compose up -d

ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --ask-vault-pass

docker compose down