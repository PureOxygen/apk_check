# apk_check
Checks for apps that may have been updated resulting in new/different scheme configurations for deep links.

The idea is to:

First - run a possible cron job to run the script and gather the version numbers

Second - compare those versions with the last script recorded version

If there is a change, download the apk and compare the manifest keywords

