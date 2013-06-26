#!/bin/bash
FLAGS="-qO-"
case $1 in
	"net-time") RUBY_SCRIPT=https://raw.github.com/aharikrishnan/ruby-lab/o/gettime.rb
		wget $FLAGS $RUBY_SCRIPT|ruby
		;;
*) echo "Invalid command specified. Refer Instruction";;
esac

