echo THIS IS A TEST SCRIPT \(parens used\)
echo $(date +'%H:%M:%S') Starting Script
echo complete
echo $(date +'%H:%M:%S') Script Complete
PS1='\[\033[01;31m\]\D{%H:%M:%S} \[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
