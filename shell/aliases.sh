# Enable aliases to be sudo’ed
alias sudo='sudo '

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias la="ls -la"
alias ll="ls -l"
alias ls='ls -G'
alias ~="cd ~"
alias dotfiles='cd $DOTFILES_PATH'

alias cdh="cd ~"
alias cdcdl="cd ~/opt/code/codelorian"
alias cdcsc="cdcdl; cd scripts"
alias cdcsv="cdcdl; cd services"
alias cdcui="cdcdl; cd ui"

alias cddc="cd *-app/src/test/resources/docker"

# Git
alias gaa="git add -A"
alias gc='$DOTLY_PATH/bin/dot git commit'
alias gca="git add --all && git commit --amend --no-edit"
alias gco="git checkout"
alias gd='$DOTLY_PATH/bin/dot git pretty-diff'
alias gs="git status -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force"
alias gpl="git pull --rebase --autostash"
alias gb="git branch"
alias gl='$DOTLY_PATH/bin/dot git pretty-log'

# Maven
alias mci="mvn clean install -U -Ddocker-maven-plugin.kafka.timeout=50000 -Ddocker-maven-plugin.app-launcher.timeout=90000" 
alias mcc="mvn clean compile" 
alias mcctc="mvn clean compile test-compile"
alias mcv="mvn clean verify" 
alias mcvl="mvn clean verify -P arch-amd64"
alias mcist="mvn clean install -DskipTests -DskipStructurizrAssembly"
alias mcis="mvn clean install sonar:sonar -U -Ddocker-maven-plugin.kafka.timeout=50000 -Ddocker-maven-plugin.app-launcher.timeout=90000" 
alias mcic="mvn clean install  -Dcucumber.filter.tags=\"@this\" -Ddocker-maven-plugin.kafka.timeout=50000 -Ddocker-maven-plugin.app-launcher.timeout=90000"
alias msbr="mvn spring-boot:run -Dspring-boot.run.profiles=dev"

alias mcie="mvn clean install --settings=$HOME/.m2/settings-ebro.xml" 
alias mciste="mvn clean install -DskipTests -DskipStructurizrAssembly --settings=$HOME/.m2/settings-ebro.xml"

alias mcij="mvn clean install --settings=$HOME/.m2/settings-javi.xml" 
alias mcistj="mvn clean install -DskipTests --settings=$HOME/.m2/settings-javi.xml"

alias adlm="aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 099590669889.dkr.ecr.eu-west-1.amazonaws.com"
alias mcim="adlm; mvn clean install --settings=$HOME/opt/Code/personal/manhattan/mvn-configuration/settings.xml" 
alias mcvm="adlm; mvn clean verify --settings=$HOME/opt/Code/personal/manhattan/mvn-configuration/settings.xml" 

# Sonar
alias cdlstart="cdcsc; ./start.sh"
alias cdlstop="cdcsc; ./stop.sh"

# Docker
alias dcd="docker-compose down --remove-orphans"
alias dcu="docker-compose up"

# Kubectl
alias kgc="kubectl config get-contexts"
alias kgpa="kubectl get pods --all-namespaces"

# Utils
alias k='kill -9'
alias i.='(idea $PWD &>/dev/null &)'
alias c.='(code $PWD &>/dev/null &)'
alias o.='open .'
alias up='dot package update_all'
