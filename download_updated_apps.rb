# ruby -r "./download_updated_apps.rb" -e "DownloadUpdatedApps.new.execute()"

require 'webdrivers'
require 'watir'
require 'rubygems'
require 'fileutils'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'diffy'
require 'headless'


class DownloadUpdatedApps

  def initialize
    @version_array = []
  end

  def execute
    clean_up_csvs
    get_release_date
    add_to_csv
    compare_csv
    download_apk
  end

  def clean_up_csvs
    File.delete("./old_versions.csv")
    File.rename("./new_versions.csv", "./old_versions.csv")
  end

  def get_release_date
    File.open("app_store_links.csv","r").readlines.each do |url|
      begin
        link = url.split(',')
        store_link = link[0]
        doc = Nokogiri::HTML(open(store_link))
        @release_date_div = doc.css('span.htlgb')[1]
        @release_date = @release_date_div.to_s.split('>').last.split('<').first
        @title_div = doc.css('h1.AHFaub').css('span')
        @title = @title_div.to_s.split('>').last.split('<').first.gsub('&acirc;','-').gsub(/&#['\d']['\d']['\d']\;/,'').gsub(/&amp;/,'')
        puts "#{@title}"
        puts "#{@release_date.chomp}"
        @version_array << ["#{@title}","#{@release_date}"]
      end
    end
  end

  def add_to_csv
    File.open("./new_versions.csv", "w") do |csv|
      @version_array.each do |line|
        csv.puts "#{line[0]},#{line[1]},#{line[2]}"
      end
    end
  end

  def compare_csv
    FileUtils.identical?('./old_versions.csv','./new_versions.csv')
    File.open("./diffs.csv", "w") do |csv|
      csv.puts Diffy::Diff.new('./old_versions.csv', './new_versions.csv', :source => 'files')
      end
  end

  def download_apk
    File.open("app_store_links.csv","r").readlines.each do |line|
      if line[0] == '+'
      google_play_link = line.split(',').first
      package_name = google_play_link.split('id=').last.split('&').first
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      browser = Selenium::WebDriver.for :chrome, options: options
      download_link = "https://apkcombo.com/apk-downloader/?device=&arch=&android=&q=#{package_name}"
      browser.get download_link
      sleep(1)
      browser.find_element(class: '_right').click
      end
    end
  end
end

