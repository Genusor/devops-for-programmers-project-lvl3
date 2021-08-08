
#terraform
init:
	cd terraform;terraform init
plan:
	cd terraform;terraform plan
apply:
	cd terraform;terraform apply

#ansible
install_req:
	ansible-galaxy install -r ansible/requirements.yml
encrypt:
	ansible-vault encrypt  ansible/group_vars/webservers/vault.yml
	ansible-vault encrypt  ansible/group_vars/datadog/vault.yml
decrypt:
	ansible-vault decrypt ansible/group_vars/webservers/vault.yml
	ansible-vault decrypt  ansible/group_vars/datadog/vault.yml
deploy:
	ansible-playbook ansible/playbook.yml -i ansible/inventory.ini  --vault-password-file ansible/pass
