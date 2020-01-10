#ruby -r "./apk_check.rb" -e "APKCheck.new.start()"

require 'rubygems'
require 'fileutils'
require 'nokogiri'
require 'pry'
require 'open-uri'
require 'csv'
require 'down'
require 'watir'

class APKCheck
  @version = []
  @name = []
  @file_name = []

  def initialize

  end

  def start
    File.open("apk_list.csv","r").readlines.each do |url|
      get_version(url)
      compare_versions
    end
    update_csv(version_array)
  end

  def get_version(url)
    begin
      version_array = []
      link = url.strip
      doc = Nokogiri::HTML(open(link))
      script = doc.search("script").to_s
      version = script.split('version_name:').last.split(',')[0].strip.gsub(/'/,'')
      name = doc.css(".title.bread-crumbs").to_s.split('name').last.split('span')[0].gsub(/\W+/, '')
      puts "#{@name}"
      puts "#{version}"
      version_array.push(version)
      end
  end

  def update_csv(version_array)
    CSV.open('v.csv','a') do |csv|
    binding.pry
       csv << [version_array]
       end
  end

  def compare_versions

  end

  def download(url)
  # ruby -r "./apk_check.rb" -e "APKCheck.new.download 'https://apkpure.com/facebook-messenger/com.facebook.orca'"

    apk = url + "/download?from=details"
     a = Watir::Browser.start apk
  end
end

