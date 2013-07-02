=begin
 @author Harikrishnan A
 @note Wasted a day in writing this program, Huh! 
=end

=begin
INPUT
UID , NAME, DOB
2009503012,Ganesh B,3/3/1992
2009503016,Harikrishnan A,5/7/1992
2009503024,A Mohaideen Hanif Rahman,11/5/1992
2009503038,SAIBHARATH S,11/11/1991
2009503020,Lakka Venkata Ramana,9/6/1992
2009503038,SAIBHARATH S,11/11/1991
2009503014,Gayathri,8/11/1991
2009503048,Thiyagu,4/6/1992
2009503054,vignesh s,4/12/1991

NOTE: Saibharath has given his name twice. so i'm forced to check for redundancy in code.
Thanks for Saibharath for helping me to find a test case.
=end

=begin OUPUT
dn: cn=Melvin Jose J,ou=student,ou=user,o=mit
objectclass: top
objectclass: inetOrgPerson
objectclass: person
objectclass: organizationalPerson
cn: Melvin Jose J
sn:  
uid: 2009503023
userPassword: 30-10-1991

=end

input_format,output_format,input_file,output_file = ARGV

if input_format.nil? or output_format.nil? or input_file.nil?
  puts "<USAGE>:\n\t1. ruby converter.rb <from> <to> <input-file> [<ouput-file>]"
  puts"\teg., $ ruby converter.rb csv ldif users.csv"
  #puts"\t2. ruby converter.rb -infile=<input-file> -outfile=<output-file> -input <input-format> -output <output-format>"
  exit
end

class String
  def parse_date_of_birth!
    #puts self
    self.chomp!.delete! " "
    day,month,year=self.split /[\/\-\.]/
    #puts "%s and %s and %s" %[date,month,year]
    #puts year.length
    year_prefix="19"
    day_prefix=month_prefix ="0"
    months={:jan=>"01", :feb=>"02", :mar=> "03",:apr=>"04", :may=> "05",:jun=> "06",:jul=> "07",:aug=> "08",:sep=> "09",:oct=> "10",:nov=> "11",:dec=>"12" }
    #convert month from words to numbers if necessary
    month= month.downcase
    
    month=month_prefix+month if month.length == 1
    day=day_prefix+day if day.length == 1
    year = year_prefix+year if year.length == 2
    
    month = months[month.to_sym] unless months[month.to_sym].nil?
    #puts "+++"+ month
    #puts "<<<<<<<<<<\tOMG\t>>>>>>>>>[%s.%s.%s]" %[day,month,year] if day.length != 2 or month.length !=2 or year.length!=4
    [day,month,year]
  end
end

output_file=input_file+"."+output_format if output_file.nil?

class Converter
  #kb is the knowledge base of Converter class
  @@kb={:CSV => 'Comma Separated File', :LDIF => 'LDAP Data Interchange Format', :LDAP => '"Did you mean LDIF instead? assuming LDIF format and proceeding!"'}

  def method_missing method, *args, &block
    super unless method =~ /[A-Z]+_to_[A-Z]+/
    from_format,to_format = method.to_s.split "_to_"
    #from_format,to_format=from_format.to_sym,to_format.to_sym
    input_desc =@@kb[from_format.to_sym]
    output_desc =@@kb[to_format.to_sym]

    input_file, output_file = args

    err_msg=''
    if input_desc.nil?
      err_msg = err_msg + "file format '#{from_format}' not known\n"
    end

    if output_desc.nil?
      err_msg = err_msg + "file format '#{to_format}' not known\n"
    end

    unless err_msg.empty?
      puts err_msg << "The known formats are:\n #{@@kb.keys}"
      exit
    end
    puts "#{from_format}, #{input_desc} --> #{to_format}, #{output_desc}."

    case from_format
    when /CSV/
      case to_format
      when /LDIF|LDAP/
        #from csv to ldif
        
        output = File.open output_file, "w"
        input = File.open input_file, "r"
        records={};
        skipped =0
        total=0
               output_template="dn: cn=%s,ou=student,ou=user,o=mit
objectclass: top
objectclass: inetOrgPerson
objectclass: person
objectclass: organizationalPerson
cn: %s
sn: %s
uid: %s
userPassword: %s\n\n"
        while line=input.gets
        unless line.empty?
        uid,name,dob = line.split ","
        total = total +1
        if records[uid.to_sym].nil?
        records[uid.to_sym]=1;
        #puts "%s\t\t%s\t\t\t\t%s" %[uid,name,dob]
        day,month,year=dob.parse_date_of_birth!
        #puts "%s\t\t%s\t\t\t\t%s" %[day,month,year]
        password = day+"-"+month+"-"+year
        #puts password+"\t"+password.length.to_s
        output.puts output_template %[name,name,name,uid,password]
        else
        puts "[INFO]\tRedundant record for #{uid} found! skipping.."
        skipped = skipped +1
        end
        end
        end
        puts "SUCCESSFULLY CONVERTED #{records.keys.length}/#{total} records skipped #{skipped} redundant records."
        else
        puts ">>OOPS!"
        end
        else
        puts ">OOPS!"
        end
        end
        end

input_format=input_format.upcase
output_format=output_format.upcase
Converter.new.send "#{input_format}_to_#{output_format}" ,input_file, output_file