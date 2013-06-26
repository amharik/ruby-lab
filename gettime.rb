require 'socket'

server, port = ARGV

if server== nil or port==nil
  puts 'usage: ruby gettime.rb <server-ip/url> <port>'
  server="time.nist.gov" #"tick.mit.edu"
  port=13
  
  msg= '*setting default values for server and port ' << server << ":" << port.to_s
  puts msg.upcase.center(72)
  
  available_time_servers = %q{
    0.in.pool.ntp.org
    1.asia.pool.ntp.org
    0.asia.pool.ntp.org
    
    nist.time.nosc.us
    nist.expertsmi.com
    nist.netservicesgroup.com
    nisttime.carsoncity.k12.mi.us
    nist1­-lnk.binary.net
    wwv.nist.gov
    time­nist.symmetricom.com
 
    nist1­macon.macon.ga.us
    nist1­atl.ustiming.org
    wolfnisttime.com
    
    for more time-server list
    [goto] http://tf.nist.gov/tf-cgi/servers.cgi
  }
  
  puts "The available time servers are:" << available_time_servers
end

time_server =  TCPSocket.open server, port

puts "response from #{server} is:".upcase.center(72)
while resp = time_server.gets
  puts resp.chop.upcase.center(72)
end
time_server.close

puts "\nPGM_EXIT :)"