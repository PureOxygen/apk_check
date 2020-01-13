# ruby -r "./apk_check.rb" -e "APKCheck.new.start()"

require 'rubygems'
require 'fileutils'
require 'nokogiri'
require 'pry'
require 'open-uri'
require 'csv'
require 'down'
require 'watir'

class APKCheck
  @name = []
  @file_name = []

  def initialize

  end

  def start
    @versions = []
    File.open("apk_list.csv","r").readlines.each do |url|
      get_version(url)
    end
    update_csv
  end

  def get_version(url)
      link = url.strip
      doc = Nokogiri::HTML(open(link))
      script = doc.search("script").to_s
      version = script.split('version_name:').last.split(',')[0].strip.gsub(/'/,'')
      name = doc.css(".title.bread-crumbs").to_s.split('name').last.split('span')[0].gsub(/\W+/, '')
      puts "#{name}"
      puts "#{version}"
      # update_csv(version)
      @versions.push(name, version)

  end

  def update_csv
    fileName = "#{Time.now.strftime('%-m:%-d:%Y')}.csv"
    finalcsv = CSV.open(fileName,'w+')
    @versions.each do |v|
      finalcsv << [v]
    end
    finalcsv.close
  end



  def compare_versions

  end

  def download(url)
  # ruby -r "./apk_check.rb" -e "APKCheck.new.download 'https://apkpure.com/facebook-messenger/com.facebook.orca'"

    apk = url + "/download?from=details"
     a = Watir::Browser.start apk
  end
end

