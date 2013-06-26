# encoding: utf-8

require 'socket'

server, port = ARGV

port =13 if port.nil?

def get_time_from server, port=13
  time_server =  TCPSocket.open server, port
  puts "response from #{server} is:".upcase.center(72)
  while resp = time_server.gets
    puts resp.upcase.center(72)
  end
  time_server.close
end

if server.nil?
  available_time_servers = %q{
    time.nist.gov
    0.in.pool.ntp.org
    1.asia.pool.ntp.org
    0.asia.pool.ntp.org

    nist.time.nosc.us
    nist.expertsmi.com
    nist.netservicesgroup.com
    nisttime.carsoncity.k12.mi.us
    nist1­-lnk.binary.net
    wwv.nist.gov
    time­-nist.symmetricom.com

    nist1-­macon.macon.ga.us
    nist1­-atl.ustiming.org
    wolfnisttime.com
  }
  puts "Enter a server number from the list:"

  %{#{
  Obfuscation= Class.new do;
  define_method :method_missing do |method, *arg, &block|;
   return "#{puts 'CHUCK NORRIS says:'+ method.to_s}"  unless method =~ /^catch_me*/;
   #super(method,*arg,&block) unless method =~ /^catch_me*/;
   ntp_servers = available_time_servers.split;
   print ntp_servers;
  puts 'total '<< ntp_servers.length << 'found';
  count=0;
   ntp_servers.each_with_index do |e,i|;
   puts '%d . %s' %[i+1,e];
   count = count+1;
   end;
   choice=0;

   puts 'your choice 1..'<< count.to_s << '> ';
   choice = gets.chop.to_i;
   
   while ( !( (1..count) === choice)  ) do;
   puts 'WARN: TYPED %d PLEASE CHOOSE VALUE BETWEEN 1 AND %d' %[choice,count];
   choice = gets.chomp.to_i;
   end;
   puts 'getting datetime  from '<< ntp_servers[choice-1] <<' ...';
   get_time_from ntp_servers[choice-1], port;
  end;
 end;
  Obfuscation.new.catch_me_if_you_can;Obfuscation.new.its_a_challenge_for_you!;
  }
}
elsif
 get_time_from server, port;
end
