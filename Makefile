install: values.json;
	mkdir -p ~/.ssh/config.d
	chmod 700 ~/.ssh
	chmod 700 ~/.ssh/config.d
	gomplate -d values.json --input-dir . --output-dir ~ ${GOMPLATE_OPTIONS}

values.json:
	echo "{\"git_user_name\": \"${GIT_USER_NAME}\", \"git_user_email\": \"${GIT_USER_EMAIL}\", \"git_ghq_root\": \"${GIT_GHQ_ROOT}\"}" > values.json
