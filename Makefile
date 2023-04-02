install: values.json .zsh/.zprezto;
	gomplate -d values.json --input-dir . --output-dir ~ ${GOMPLATE_OPTIONS}
	mkdir -p ~/.ssh/config.d

.zsh/.zprezto:
	git clone --recursive https://github.com/sorin-ionescu/prezto.git $@ || git -C .zsh/.zprezto pull
	git -C .zsh/.zprezto submodule update --init --recursive

values.json:
	echo "{\"git_user_name\": \"${GIT_USER_NAME}\", \"git_user_email\": \"${GIT_USER_EMAIL}\", \"git_ghq_root\": \"${GIT_GHQ_ROOT}\"}" > values.json
