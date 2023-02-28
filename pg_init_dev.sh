sudo apt update > /dev/null
echo $(date +'%H:%M:%S') Apt installing libraries \(30secs\)
sudo apt-get install -y locate build-essential libreadline-dev zlib1g-dev flex bison libxml2-dev libxslt-dev libssl-dev libxml2-utils xsltproc ccache > /dev/null
echo "starting the remainder"
#some keys I cannot live without... LOL
set -o emacs
bind '"\e[19~": history-search-backward'
bind '"\C-x\C-k": kill-whole-line'
bind '"\C-k\C-k": kill-whole-line'
PS1='\[\033[01;31m\]\D{%H:%M:%S} \[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
echo " PS1='\[\033[01;31m\]\D{%H:%M:%S} \[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> ~/.bashrc
if [[ ! -z "${patchUrl}" ]]; then echo "PATCH: ${patchUrl}"; wget $patchUrl; patch -p1 < $(ls *.patch); fi
mkdir ~/pg_local
./configure --prefix=$(echo ~/pg_local) --enable-depend --enable-cassert --with-libxml > /dev/null
echo $(date +'%H:%M:%S') Starting Build \(2min 30secs\)
make -j$(grep -c processor /proc/cpuinfo) > /dev/null
echo $(date +'%H:%M:%S') Starting Install
make install > /dev/null
echo $(date +'%H:%M:%S') Initializing DB
~/pg_local/bin/initdb -D ~/pgdata
/home/gitpod/pg_local/bin/pg_ctl -D /home/gitpod/pgdata -l pg.log start
/home/gitpod/pg_local/bin/psql postgres -c "create database gitpod"
echo $(date +'%H:%M:%S') Fixing Path
export PATH=$PATH:/home/gitpod/pg_local/bin  > /dev/null
echo 'set revert-all-at-newline On' >> ~/.inputrc
echo '"\e[19~": history-search-backward' >> ~/.inputrc
echo '"\C-x\C-k": kill-whole-line' >>  ~/.inputrc
echo '"\C-k\C-k": kill-whole-line' >>  ~/.inputrc
alias help='echo "" && echo "Frequent Commands" && echo psql postgres -- Connect to postgres && echo pg_ctl -D /home/gitpod/pgdata stop && echo make && echo make install && echo pg_ctl -D /home/gitpod/pgdata start'
echo "" && echo Postgres installed. && echo Type help for commands && echo To connect, use: && echo psql postgres && echo ""
# you reference this file like this: bash <(curl -s https://raw.githubusercontent.com/kirkw/config_scripts/main/pg_init_dev.sh)
