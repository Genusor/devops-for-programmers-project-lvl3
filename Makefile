
#terraform
init:
	terraform -chdir=terraform/ init
plan:
	terraform -chdir=terraform/ plan
apply:
	terraform -chdir=terraform/ apply

#ansible
install_req:
	ansible-galaxy install -r ansible/requirements.yml
encrypt:
	ansible-vault encrypt  ansible/group_vars/webservers/vault.yml ansible/group_vars/datadog/vault.yml --vault-password-file ansible/pass

decrypt:
	ansible-vault decrypt ansible/group_vars/webservers/vault.yml ansible/group_vars/datadog/vault.yml --vault-password-file ansible/pass

deploy:
	ansible-playbook ansible/playbook.yml -i ansible/inventory.ini  --vault-password-file ansible/pass
