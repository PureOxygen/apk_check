# apk_check
Checks for apps that may have been updated resulting in new/different scheme configurations for deep links.

Before you start:
-install apk tools on your system: https://ibotpeaches.github.io/Apktool/
    - A good tutorial/easier way of installation than the docs is here: http://macappstore.org/apktool/

-Make sure to install any of the gems in the require section since there is no gemfile

Run the scripts:
-First you'll need to download the apps: `ruby -r "./download_updated_apps.rb" -e "DownloadUpdatedApps.new.execute()"`
    - This only downloads the app if it has been updated on the Google Play store

-Second we need to scrape the app for our keywords, and put those in a new csv. The scripts previously in the new_apk folder will now be in the old_apk folder. 
    This script also compares the differences of those csv's and puts those changes in "./apk_diffs".
    `ruby -r "./check_diff.rb" -e "CheckDiff.new.execute()"`
