#!/bin/bash
FLAGS="-q -O -"
echo $0

if [ x"$2" != "x" ]; then
echo "setting server name as '$2'"
fi

if [ x"$3" != "x" ]; then
echo "setting port name as '$3'"
fi

case $1 in
	"net-time") RUBY_SCRIPT=https://raw.github.com/aharikrishnan/ruby-lab/o/gettime.rb
		echo "connecting to: $RUBY_SCRIPT"
		RUBY_FILE=`tempfile`
		echo "created a temporary file $RUBY_FILE"
		#wget $FLAGS $RUBY_SCRIPT | ruby
		wget $FLAGS $RUBY_SCRIPT > $RUBY_FILE
		
		if [ "x$2" != "x" ]; then
			if [ "x$3" != "x" ]; then
				ruby  $RUBY_FILE -s -host=$2 -port=$3
			else
				ruby  $RUBY_FILE -s -host=$2
			fi
		else
			ruby  $RUBY_FILE
		fi
		#ruby /tmp/ins.rb -url="afafa" -daytime="13"
		;;

	*) 	echo "Invalid command specified. Refer Instruction"
		echo "USAGE: 1. run.sh net-time <host> <port>"
	;;
esac
