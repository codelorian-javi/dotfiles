function cdd() {
	cd "$(ls -d -- */ | fzf)" || echo "Invalid directory"
}

function j() {
	fname=$(declare -f -F _z)

	[ -n "$fname" ] || source "$DOTLY_PATH/modules/z/z.sh"

	_z "$1"
}

function recent_dirs() {
	# This script depends on pushd. It works better with autopush enabled in ZSH
	escaped_home=$(echo $HOME | sed 's/\//\\\//g')
	selected=$(dirs -p | sort -u | fzf)

	cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}

function setup_trinity() {
  export AWS_PROFILE=gymi
  awslogin --profile gymi
  #aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 713881818102.dkr.ecr.eu-west-1.amazonaws.com
  export DOCKER_REGISTRY_URL='713881818102.dkr.ecr.eu-west-1.amazonaws.com'
  export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain gymi --domain-owner 713881818102 --region eu-west-1 --query authorizationToken --output text`
}
