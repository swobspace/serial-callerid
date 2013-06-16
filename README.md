serial-callerid
===============

Watch a serial line modem for incoming calls and start an external 
program on the first RING. The external program must be defined in
the param 'action_url' . 'action_url' can contain the pattern 
'###callerid###', which will be substituted by the real caller id
(see config.yml for an example).

This program makes use of ruby-serialport 
from https://github.com/hparra/ruby-serialport.git

(c) 2013 Wolfgang Barth wob@swobspace.de
