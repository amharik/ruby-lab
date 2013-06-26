  Obfuscation= Class.new do
  define_method :method_missing do |method, *arg, &block|

   return "method not found" unless method =~ /^catch_me*/

   ntp_servers = available_time_servers.split
  puts 'total '<< ntp_servers.length << 'found'
  count=0
   ntp_servers.each_with_index do |e,i|
   puts '%d . %s' %[i,e];
   count =i
   end;
   choice=0;
   puts 'your choice 1..'<< count << '> '

   choice = gets.chomp
   choice = choice.to_i

   while !(choice === (1..ntp_servers.length)) do
   puts 'WARN:'<< choice <<' PLEASE CHOOSE VALUE BETWEEN 1 AND ' << count.to_s
   choice = gets.chop!.to_i
   end
   puts 'getting datetime  from '<< ntp_servers[choice-1] <<' ...'
  end
 end;
  Obfuscation.new.catch_me_if_you_can;