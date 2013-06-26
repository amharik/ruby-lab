#!/bin/bash
FLAGS="-q -O -"
echo $0

if [ x"$2" != "x" ]; then
echo $2
fi

if [ x"$3" != "x" ]; then
echo $3
fi

case $1 in
	"net-time") RUBY_SCRIPT=https://raw.github.com/aharikrishnan/ruby-lab/o/gettime.rb
		echo "connecting to: $RUBY_SCRIPT"
		if [ "x$2" != "x" ]; then
			if [ "x$3" != "x" ]; then
				HOST=$2	
				PORT=$3
				wget $FLAGS $RUBY_SCRIPT | ruby
				#wget $FLAGS $RUBY_SCRIPT >/tmp/ins.rb
				#ruby /tmp/ins.rb -url="afafa" -daytime="13"
			fi
		fi
		;;
*) echo "Invalid command specified. Refer Instruction";;
esac

