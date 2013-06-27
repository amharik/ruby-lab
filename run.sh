#!/usr/bin/env bash


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
		
		OLD_RUBY_FILE=`tempfile`
		
		
		RUBY_FILE="$OLD_RUBY_FILE.rb"
		touch $RUBY_FILE

		echo "created a temporary file $RUBY_FILE"
		#wget $FLAGS $RUBY_SCRIPT | ruby
		#wget $FLAGS $RUBY_SCRIPT > $RUBY_FILE
		#curl -Ls "file:///home/dreamer/workspace-ror/LearnRubyTheHardWay/network/gettime.rb" > $RUBY_FILE
		curl -Ls $RUBY_SCRIPT > $RUBY_FILE
		if [ "x$2" != "x" ]; then
			if [ "x$3" != "x" ]; then
				`which ruby` $RUBY_FILE -s -host=$2 -port=$3
			else
				`which ruby` $RUBY_FILE -s -host=$2
			fi
		else
			`which ruby`  $RUBY_FILE
		fi
		
		rm $RUBY_FILE
		rm $OLD_RUBY_FILE
		echo "cleaned $RUBY_FILE and $OLD_RUBY_FILE\nBYE."
		;;

	*) 	echo "Invalid command specified. Refer Instruction"
		echo "USAGE:\n\t1. run.sh net-time <host> <port>"
		echo "\t2.curl -Ls  'https://raw.github.com/aharikrishnan/ruby-lab/o/run.sh'| bash -s net-time time.nist.gov"
	;;
esac
