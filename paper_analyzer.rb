#!/usr/bin/ruby
# coding: utf-8
#----------------------------------------------
#    Data: May 11st, 2017                                          
#    Author: Xiaolun Cao                                          
#    Description:
#    1) Traverse script for scanning multiple files for retrieving
#       specific keywords and count their occurrence.
#    2) CSV-format output file supported.
#    3) Dedicated to Yue.Ren
#----------------------------------------------
 
 
=begin
CSV-format?:
Keyword, Paper_name, Occurrence, Publish_year
 
=end
 
# Traverse Whole Directory 
#----------------------------
Encoding::ISO_8859_1.names
 
if (File.exist?("result.dat"))
  File.delete("./result.dat")
else
end
if (File.exist?("Retrival.csv"))
  File.delete("./Retrival.csv")
else
end
 
 def traverse(path,file,word)
   if File.directory?(path)
     dir = Dir.open(path)
     while name = dir.read
       next if name == "."
       next if name == ".."
       next if name == "result.dat"
       next if name.include?(".rb")
       next if name.include?(".csv")
        
       traverse(path+"/"+name,name,word)
     end
   else
     if (path.include?("~")||path.include?("#"))
     else
       total_occurrence=process_file(path,file,word)
     end
   end
   return total_occurrence
 end
 
# Targetted File Processing 
#----------------------------
 def process_file(path,filename,word)
   #line_num = 1
   file_occurrence=0
   count_hash=Hash.new(0)
   database_cnt=Array.new()
   year=1999
   title="NULL"
   author="NOWHO"
   #author=filename[/_(\p{Han}+).txt/]
   filename.scan(/(\S+)_(\S+)_([0-9]+).txt/) do |title_temp, author_temp, year_temp|
     title=title_temp
     author=author_temp
     year=year_temp
     p title_temp.to_s
     p author_temp.to_s
   end
   File.open (path) do |file|
     File.open("./Retrival_1.csv", "a") do |data|
       while line = file.gets
         line=line.chomp
         #puts line
         for i in 0..($Database.size-1)
           if (line.include?($Database[i]))
             #string = /博物馆/.match(line)
           count_hash[$Database[i]]=line.scan(/(?=#{$Database[i]})/).count
           #database_cnt[i]=line.scan(/(?=#{$Database[i]})/).count
           #puts "count : "+line.count(word).to_s
           #data.puts path+"::"+filename+"::"+line_num.to_s#+"::"+line+"\n"
           #print word.to_s,",",filename.to_s,",",line_num#,",",line,"\n"
           #file_occurrence=file_occurrence+1
           else
             next
           end
         end
         #print filename.to_s,",",database_cnt[0],",",database_cnt[1],",",database_cnt[2], "\n"
         print title.to_s,",",author.to_s,",",year.to_s,",",count_hash[$Database[0]],",",count_hash[$Database[1]],",",count_hash[$Database[2]], ",",count_hash[$Database[3]],",",count_hash[$Database[4]],",",count_hash[$Database[5]],",", count_hash[$Database[6]],",",count_hash[$Database[7]],",",count_hash[$Database[8]],",",count_hash[$Database[9]],",",count_hash[$Database[10]],",",count_hash[$Database[11]], ",", count_hash[$Database[12]],",",count_hash[$Database[13]],",",count_hash[$Database[14]], ",",count_hash[$Database[15]],",",count_hash[$Database[16]],",",count_hash[$Database[17]],",",count_hash[$Database[18]],",",count_hash[$Database[19]],",",count_hash[$Database[20]],"\n"
         data.print title.to_s,",",author.to_s,",",year.to_s,",",count_hash[$Database[0]],",",count_hash[$Database[1]],",",count_hash[$Database[2]], ",",count_hash[$Database[3]],",",count_hash[$Database[4]],",",count_hash[$Database[5]],",", count_hash[$Database[6]],",",count_hash[$Database[7]],",",count_hash[$Database[8]],",",count_hash[$Database[9]],",",count_hash[$Database[10]],",",count_hash[$Database[11]], ",", count_hash[$Database[12]],",",count_hash[$Database[13]],",",count_hash[$Database[14]], ",",count_hash[$Database[15]],",",count_hash[$Database[16]],",",count_hash[$Database[17]],",",count_hash[$Database[18]],",",count_hash[$Database[19]],",",count_hash[$Database[20]],"\n"
         #p filename.to_s+":: 频度 "+line.scan(/(?=#{word})/).count.to_s       
         #line_num = line_num + 1
       end
     end
   end
   #puts "file_occurrence: "+file_occurrence.to_s
   return file_occurrence
 end
 
 # Keyword Vocabulary
 $Database = Array.new() #Placeholder for keyword
 # Institution
 $Database[0]="博物馆"
 $Database[1]="美术馆"
 $Database[2]="艺术馆"
 $Database[3]="画廊"
 $Database[4]="艺术区"
 # Internet Methods
 $Database[5]="数字化"
 $Database[6]="线上"
 $Database[7]="智能"
 $Database[8]="数字技术"
 $Database[9]="新媒体"
 $Database[10]="网络"
 $Database[11]="互联网"
 # Subjects
 $Database[12]="展览"
 $Database[13]="艺术展览"
 $Database[14]="艺术作品"
 $Database[15]="作品展示"
 $Database[16]="APP"
 $Database[17]="应用程序"
 $Database[18]="应用软件"
 # Interactive Design
 $Database[19]="用户"
 $Database[20]="交互设计"
  
  
# Main Program
#----------------------------
 root = "./"
 input_word = "NULL"
 $Database_pointer_i=0
 $Database_pointer_o=0
 $hash=Hash.new(0)
 #while input_word != "!q" do
   #puts "Please input the string you want: (Enter '!q' to finish)"
   #input_word = gets.chomp
   #if input_word!="!q"
   #  $Database[$Database_pointer_i]=input_word
   #else
   #  puts "!q Detected. Sampling Finished"
   #end
   #$Database_pointer_i=$Database_pointer_i+1
 #end
 #puts $Database[0]+":"+$Database[1]
 #for i in 0..($Database.size-1) do
 File.open("./Retrival.csv", "a") do |data|
   data.print "论文题目",",","作者",",","发表年",",",$Database[0].to_s,",",$Database[1].to_s,",",$Database[2].to_s,",",$Database[3].to_s,",",$Database[4].to_s,",",$Database[5].to_s,",",$Database[6].to_s,",",$Database[7].to_s,",",$Database[8].to_s,",",$Database[9].to_s,",",$Database[10].to_s,",",$Database[11].to_s,",",$Database[12].to_s,",",$Database[13].to_s,",",$Database[14].to_s,",",$Database[15].to_s,",",$Database[16].to_s,",",$Database[17].to_s,",",$Database[18].to_s,",",$Database[19].to_s,",",$Database[20].to_s,"\n"
 end
 top_occurrence=traverse(root,""," ")
 puts "top_occurrence: "+top_occurrence.to_s
 #end
 puts $hash
  
 exit
