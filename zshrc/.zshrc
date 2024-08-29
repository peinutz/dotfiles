# .zshrc

fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

kill_node_processes() {
    local NODE_PROCESS_IDS
    NODE_PROCESS_IDS=$(pgrep -f "node")

    if [ -n "$NODE_PROCESS_IDS" ]; then
        echo "Terminating Node processes:"
        echo "$NODE_PROCESS_IDS" | xargs kill -9
        echo "Node processes terminated."
    else
        echo "No Node processes running."
    fi
}

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'


alias awsume=". awsume"

# Z jumparound
. ~/repositories/z/z.sh

alias jmp-all='ssh-via-ssm -N -L 5434:$(credstash -t planning-applications-pipeline get PLANNING_POSTGRES_HOST):5432 -L 5433:$(credstash get  "main-api/POSTGRES_INSTANCE_STRING"):5432 -L 27001:$(aws ec2 describe-instances --filter "Name=tag:Name,Values=planning-mongo-staging-*" --query "Reservations[*].Instances[?State.Name == "running"].{PrivateDnsName:PrivateDnsName}[0]" --output text):27017'

alias resize='tmux resize-window -R 90'

alias gl='git pull'
alias ga='git add .'
alias gcm='git checkout main'
alias gs='git status'
alias gcmsg='git commit -m'
alias gp='git push'
alias gac='git add-commit -m'
alias gcb='git checkout -b'
alias gpu='git push --set-upstream origin $(git branch --show-current)'
alias pr='gh pr create'
alias gbin='git checkout -- .'
alias gres='git checkout origin/main'

##AWS
alias awsume=". awsume"
alias login-prod="aws-sso-util login --profile prod-engineer"
alias assume-prod='unset AWS_PROFILE && awsume prod-engineer'
alias login-prod-admin="aws-sso-util login --profile prod-admin"
alias assume-prod-admin='unset AWS_PROFILE && awsume prod-admin'
alias login-staging="aws-sso-util login --profile stage-engineer"
alias assume-staging='unset AWS_PROFILE && awsume stage-engineer'
alias ast='login-staging && unset AWS_PROFILE && awsume stage-engineer && export AWS_PROFILE=stage-engineer'
alias assume-staging-admin='unset AWS_PROFILE && awsume stage-admin'
alias get-aws-keys='cat ~/.aws/credentials'


### # # # # # # # # # # # # # # # # # #  LANDTECH ## # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   
##DATABASES
export LANDB_ID_STAG='5daeccaf9eb0a70eafff9525'
export LANDB_ACCOUNT_STAG='5daeccaf9eb0a70eafff9524'

##LANDDB
alias jmp-landdb-stag='ssh-ssm.sh -t -l 27019 -P 27017 -H ec2-34-248-163-221.eu-west-1.compute.amazonaws.com'
alias jmp-landdb-prod='ssh-ssm.sh -t -l 27019 -P 27017 -H ec2-34-243-252-154.eu-west-1.compute.amazonaws.com'

alias conn-landdb='mongosh "mongodb://localhost:27019/landdb?readPreference=secondary"'
alias start-mongo-local='docker run -d -p 27017:27017 mongo:3.6.23'

##JUMPBOXES

alias jump-planning-prod='ssh-via-ssm -N -L 5434:planningrdspostgres-planningpipelinerdspostgresc7-1vg6rurlpg1z0.cluster-cblsxmfiejdk.eu-west-1.rds.amazonaws.com:5432'
alias conn-planning-pg='psql $(credstash -t planning-applications-pipeline get PLANNING_POSTGRES_CONNECTION_STRING)'

alias jmp-es='~/repositories/ssm-ssh-jumpbox/scripts/jump-tunnel.sh -n 'BastionHost' -l 9200 -P 80 -H 'search-landtech-es-staging-6-2c-ishcsuq2ph73qbhkwtagzk4pke.eu-west-1.es.amazonaws.com''
alias jmp-es-prod='~/repositories/ssm-ssh-jumpbox/scripts/jump-tunnel.sh -n 'BastionHost' -l 9200 -P 80 -H 'search-landtech-es-prod-6-2-asbwnnroqosnfzlyowgki2ir7a.eu-west-1.es.amazonaws.com''

##KUBERNETES
alias kb='kubectl'
alias k8-ownership='kubectl config set-context --current --namespace=ownership-alerts'
alias k8-pedro='kubectl config set-context --current --namespace=pedro'
alias k8-ctx='kubectl config current-context'
alias aws-sandbox="aws-assume-role --account sandbox --role administrator --profile default && export AWS_PROFILE=sandbox"
alias k8-sandbox="aws-sandbox && k8-install-cluster-user --cluster k8.sandbox.landinsight.io --aws-profile sandbox"
alias aws-staging="unset AWS_PROFILE"
alias k8-staging="aws-staging && kubectl config use-context k8.staging.landinsight.io"
alias aws-prod="unset AWS_PROFILE; aws-assume-role --account production --role engineer --profile default && export AWS_PROFILE=production"
alias k8-prod="aws-prod && k8-install-cluster-user --cluster k8.landinsight.io --aws-profile production"

## DOCS STUFF
alias docs='alias | grep '
alias edita='lvim ~/.zshrc'
alias reload='source ~/.zshrc'
alias openci='open https://circleci.com/gh/landtechnologies/workflows/$(basename `git rev-parse --show-toplevel`)'

#Useful things
alias scripts='cat package.json | jq .scripts'
alias rmnpm=' rm -rf node_modules && npm i'
alias kill='pkill -9 ' 

#DOCKER
alias docker-stop='docker stop $(docker ps -a -q)'
alias docker-remove='docker rm $(docker ps -a -q)'
alias dcu='docker compose up'
alias dcd='docker compose down'

export PATH="$HOME/.bin:$PATH"
export PATH="$PATH:/usr/local/opt/mongodb-community@3.6/bin"
export PATH="/Users/pedro/repositories/ssm-ssh-jumpbox/scripts:$PATH"
export PATH="/opt/homebrew/Cellar/libpq/14.2/bin/:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
<<<<<<< HEAD

=======
>>>>>>> 8413211 (remove secrets)
export LOCAL_USER_MONGO_EMAIL='pedro+pro@land.tech'


 #add pg_config to path to build psycopg2 https://github.com/psycopg/psycopg2/issues/1200#issuecomment-946436396
export PATH="/opt/homebrew/Cellar/libpq/14.1/bin:$PATH"
export PATH="/usr/local/opt/mongodb-community@3.6/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"
export PATH="/opt/homebrew/Cellar/libpq/14.1/bin:$PATH"
export PATH="/Users/pedro/.local/bin/lvim:$PATH"
export PATH="$PATH:./node_modules/.bin"
source "$HOME/.cargo/env"


# Get the connection string from PG connection string
extract_pg_info() {
  while read -r connection_string; do
    user=$(echo $connection_string | sed -n 's/.*\/\/\([^:]*\):.*/\1/p')
    password=$(echo $connection_string | sed -n 's/.*\/\/[^:]*:\([^@]*\)@.*/\1/p')
    database=$(echo $connection_string | sed -n 's/.*\/\([^?]*\).*/\1/p')

    echo "User: $user"
    echo "Password: $password"
    echo "Database: $database"
  done
}

get_pg_info() {
  local port=$1
  while read -r connection_string; do
    user=$(echo $connection_string | sed -n 's/.*\/\/\([^:]*\):.*/\1/p')
    password=$(echo $connection_string | sed -n 's/.*\/\/[^:]*:\([^@]*\)@.*/\1/p')
    database=$(echo $connection_string | sed -n 's/.*\/\([^?]*\).*/\1/p')

    echo "User: $user"
    echo "Password: $password"
    echo "Database: $database"
    echo "Port: $port"
    echo "Host: localhost"
    echo "Connection String: postgresql://$user:$password@localhost:$port/$database"
  done
}

build_connection_string() {
  local table=$1
  local port=$2
  credstash get $table | get_pg_info $port
}

# Example usage:
# build_connection_string "constraints/POSTGRES_READONLY_CONNECTION_STRING" 5432
# 
alias build_pg_connection='build_connection_string'

alias constraints-info='credstash get constraints/POSTGRES_READONLY_CONNECTION_STRING | extract_pg_info'
alias constraints-pg-info='build_pg_connection constraints/POSTGRES_READONLY_CONNECTION_STRING 5435'

# FNM to automatically assume folder version 
# eval "$(pyenv init --path)"
# if [ -x "$(command -v fnm)" ]; then
#                 eval "$(fnm env --use-on-cd)"
# fi

# bun completions
[ -s "/Users/pedro/.bun/_bun" ] && source "/Users/pedro/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
