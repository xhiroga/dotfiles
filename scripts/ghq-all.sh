
PERSONAL_ACCESS_TOKEN=$1
curl -s "https://api.github.com/user/repos?access_token=${PERSONAL_ACCESS_TOKEN}&type=all" \
    | jq .[].full_name -r \
    | ghq import
