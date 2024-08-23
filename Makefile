install: values.json;
	mkdir -p ~/.ssh/config.d
	chmod 700 ~/.ssh
	chmod 700 ~/.ssh/config.d
	gomplate -d values.json --input-dir . --output-dir ~ ${GOMPLATE_OPTIONS}

values.json:
	@if ! ssh -T git@github.com 2>&1 | grep -q "Hi xhiroga!"; then echo "Authentication failed. Are you @xhiroga?"; exit 1; fi
	echo '{"git_user_name": "Hiroaki Ogasawara", "git_user_email": "13391129+xhiroga@users.noreply.github.com"}' > values.json
