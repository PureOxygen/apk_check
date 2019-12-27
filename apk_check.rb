#ruby -r "./apk_check.rb" -e "APKCheck.new.start()"

require 'rubygems'
require 'fileutils'
require 'nokogiri'
require 'pry'
require 'open-uri'
require 'csv'
require 'down'

class APKCheck
  @version = []
  @name = []
  @file_name = []

  def initialize

  end

  def start
    File.open("apk_list.csv","r").readlines.each do |url|
      run_test(url)
      download(url)
    end
  end

  def run_test(url)
    begin
      link = url.strip
      doc = Nokogiri::HTML(open(link))
      script = doc.search("script").to_s
      @version = script.split('version_name:').last.split(',')[0].strip.gsub(/'/,'')
      @name = doc.css(".title.bread-crumbs").to_s.split('name').last.split('span')[0].gsub(/\W+/, '')

      # Find a way to compare versions and find when they are updated
      # if match = false download(url)

      puts "#{@name}"
      puts "#{@version}"
      end
  end

  def download(url)
  # ruby -r "./apk_check.rb" -e "APKCheck.new.download 'https://apkpure.com/facebook-messenger/com.facebook.orca'"

    link = url.strip
    begin
      tempfile = Down.download(link)
      FileUtils.mv(tempfile.path, "./apk/#{tempfile.original_filename}")
    end
  end
end

