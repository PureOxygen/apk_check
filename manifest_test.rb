require 'rubygems'
require 'fileutils'
require 'nokogiri'

file_name_input = ARGV
puts "File name input: #{file_name_input}"
current_path = Dir.pwd
manifest_files_path = File.join(current_path, "./apk")
path_and_name = "#{manifest_files_path}#{file_name_input.first}"
puts path_and_name

# doc = Nokogiri.parse(File.read(path_and_name))
# doc.css("intent-filter").each do |intent_filter|
#   intent_filter.children.each do |child|
#     puts "#"*100
#     puts child
#   end
# end

doc = Nokogiri.parse(File.read(path_and_name))
filterData = "intent-filter.data."

fileName = file_name_input.join(" ").gsub(/.txt/, '')
puts "#"*100
puts ("The file name is: #{fileName}")

scheme = doc.search("data").each do |i|
  i.each do |att_name, att_value|
    # puts "{:#{att_name}=> '#{att_value}'}"
    links = {"#{att_name}" => att_value}
    puts "#"*100
    puts links
  end

end




#run "ruby android_scheme_discovery2.rb [FileName with .txt]" minus brackets
