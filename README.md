# live music in opencomputers!
### warning: very wip

`stream` is a bash program that streams your default audio input as dfpwm data.  
requires: sox & socat  
usage: `./stream [sample rate] [port]`  

`live` is an opencomputers lua program that plays that stream  
requires: an internet card and a tape drive + tape  
usage: `live <address> <port> [--bitrate=bitrate]`  
