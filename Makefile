install: values.json update;
	gomplate -d values.json --input-dir . --output-dir ~ ${GOMPLATE_OPTIONS}
	mkdir -p ~/.ssh/config.d

update: .zsh/.zprezto;
	git -C .zsh/.zprezto pull
	git -C .zsh/.zprezto submodule update --init --recursive

.zsh/.zprezto:
	git clone --recursive https://github.com/sorin-ionescu/prezto.git $@

values.json:
	echo "{\"git_user_name\": \"${GIT_USER_NAME}\", \"git_user_email\": \"${GIT_USER_EMAIL}\", \"git_ghq_root\": \"${GIT_GHQ_ROOT}\"}" > values.json
