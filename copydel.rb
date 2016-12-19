# coding: utf-8
require 'fileutils'

def copy(src, dst)
  FileUtils.cp(src, dst)
end

files = Dir.entries("/media/sf_temp")
doc_arr = Array.new
files.each do |x| 
  if x =~ /doc$/ 
    puts "Работаю с файлом: " + x
    doc_arr.push(x)
    src = "/media/sf_temp/#{x}"
    dst = "/home/strike/article/#{x}"
    copy(src,dst)
    FileUtils.chown 'strike', 'strike', "/home/strike/article/#{x}"
  end
end

`sudo -u strike java -jar /home/strike/IdeaProjects/article/out/artifacts/article_jar/article.jar`

puts "Java отработала"

files_txt = Dir.entries("/home/strike/article")
txt_arr = Array.new
files_txt.each do |y|
  if y =~ /txt$/
    txt_arr.push(y)
    puts "Работаю с файлом: " + y
    srt_txt = "/home/strike/article/#{y}"
    dst_txt = "/media/sf_temp/#{y}"
    FileUtils.chown 'root', 'root', "/home/strike/article/#{y}"
    copy(srt_txt,dst_txt)
  end
end

FileUtils.rm Dir.glob('/home/strike/article/*')

puts "Работа завершена."
