
PERSONAL_ACCESS_TOKEN=$1
ORG=$2
curl -s "https://api.github.com/orgs/${ORG}/repos?access_token=${PERSONAL_ACCESS_TOKEN}&type=all" \
    | jq .[].full_name -r \
    | ghq import
