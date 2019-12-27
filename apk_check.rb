#ruby -r "./apk_check.rb" -e "APKCheck.new.start()"


require 'rubygems'
require 'fileutils'
require 'nokogiri'
require 'pry'
require 'open-uri'
require 'csv'

class APKCheck
  @version = []
  @name = []
  @file_name = []

  def initialize

  end

  def start
    File.open("apk_list.csv","r").readlines.each do |url|
      run_test(url)
    end
  end

  def run_test(url)
    begin
      link = url.strip
      doc = Nokogiri::HTML(open(link))
      @script = doc.search("script").to_s
      @version = @script.split('version_name:').last.split(',')[0].strip.gsub(/'/,'')
      # Find a way to compare versions and find when they are updated
      # if match = false download(url)
      puts "#{@version}"
       binding.pry
      end
  end

  def download(url)
  # ruby -r "./apk_check.rb" -e "APKCheck.new.download 'https://apkpure.com/facebook-messenger/com.facebook.orca'"
    open(url + "/download?from=details") do |apk|
    File.open("./Messenger – Text and Video Chat for Free_v245.0.0.19.113_apkpure.com.apk", "wb") do |file|
      file.write(apk.read)
    end
  end

  def name

  end

  def download_current_version
    puts "This is download current version"
  end
end

