echo THIS IS A TEST SCRIPT \(parens used\)
echo $(date +'%H:%M:%S') Starting Script
echo complete
echo $(date +'%H:%M:%S') Script Complete
export PS1='\[\033[01;31m\]\D{%H:%M:%S} \[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# F8 is an addiction (type 2-3 characters, hit F8 to search backwards for that command.  Imagine !vs + AUTO COMPLETE without execute
echo '"\e[19~": history-search-backward' >> ~/.inputrc
# I need a way to change my bashrc and my inputrc
