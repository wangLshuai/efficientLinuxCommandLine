#!/usr/bin/expect
spawn ssh wang@localhost
expect {
	"yes/no" {send "yes\r";exp_continue}
	"password:" { send "wang@1116\r" }
}

# expect "#"
# send "who\r
# expect eof
send "who\r"
interact