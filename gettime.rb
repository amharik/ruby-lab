#! /usr/local/bin/ruby -s
require 'socket'

def get_time_from server, port=13
  puts "getting datetime  from #{server} on port #{port}..."
  time_server =  TCPSocket.open server, port
  puts "response from #{server} is:".upcase.center(72)
  while resp = time_server.gets
    puts resp.upcase.center(72)
  end
  time_server.close
end

available_time_servers = %w(time.nist.gov    0.in.pool.ntp.org    1.asia.pool.ntp.org    0.asia.pool.ntp.org    nist.time.nosc.us    nist.expertsmi.com    nist.netservicesgroup.com    nisttime.carsoncity.k12.mi.us    nist1­-lnk.binary.net    wwv.nist.gov   time­-nist.symmetricom.com    nist1-­macon.macon.ga.us   nist1­-atl.ustiming.org    wolfnisttime.com)

define_method :print_server_list do
  puts "Enter a server from the list the default port is 13"
  count=0;
  available_time_servers.each_with_index do |e,i|;
    puts '%d . %s' %[i+1,e];
    count = count+1;
  end;
  puts 'total '<< count.to_s << ' servers found in local arranged in order of hit ratio';
=begin
  puts 'your choice 1..'<< count.to_s << '> ';
  choice=1
  #choice=gets
  choice=choice.to_i;
  while ( !( (1..count) === choice)  ) do;
    puts 'WARN: TYPED %d PLEASE CHOOSE VALUE BETWEEN 1 AND %d' %[choice,count];
    choice = gets
    choice = choice.to_i
  end
=end
puts "BYE."
exit
end

if $host.respond_to?:to_str
  host = $host
  puts 'setting host as '<< host
else
  print_server_list
end

if $port.respond_to?:to_str
  port = $port
  port = port.to_i
  puts 'setting port as '<< port.to_s
else
port = 13
end

%{#{
  Obfuscation= Class.new do;
  define_method :method_missing do |method, *arg, &block|;
   return "#{puts 'CHUCK NORRIS says: '+ method.to_s}"  if (method =~ /^its_a_cha*/;)
   return super(method,*arg,&block) unless method =~ /^(catch_me*|its_a_cha*)/;
      get_time_from host, port;
  end;
 end;
  Obfuscation.new.catch_me_if_you_can;Obfuscation.new.its_a_challenge_for_you!;
  }}
