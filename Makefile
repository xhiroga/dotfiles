values.json:
	echo "{\"git_user_name\": \"$${GIT_USER_NAME}\", \"git_user_email\": \"$${GIT_USER_EMAIL}\", \"ansible_priority_roles_path\": \"$${ANSIBLE_PRIORITY_ROLES_PATH}:\", \"ansible_vault_password_file\": \"$${ANSIBLE_VALUE_PASSWORD_FILE}\"}" > values.json

install: values.json;
	gomplate -d values.json --input-dir . --output-dir ~
