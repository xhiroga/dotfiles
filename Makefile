install: values.json update;
	gomplate -d values.json --input-dir . --output-dir ~

update: .zsh/.zprezto;
	git -C .zsh/.zprezto pull
	git -C .zsh/.zprezto submodule update --init --recursive

.zsh/.zprezto:
	git clone --recursive https://github.com/sorin-ionescu/prezto.git $@

values.json:
	echo "{\"git_user_name\": \"${GIT_USER_NAME}\", \"git_user_email\": \"${GIT_USER_EMAIL}\", \"ansible_priority_roles_path\": \"$${ANSIBLE_PRIORITY_ROLES_PATH}:\", \"ansible_vault_password_file\": \"${ANSIBLE_VALUE_PASSWORD_FILE}\"}" > values.json
