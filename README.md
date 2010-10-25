                  ___  _____  _____  __ _  _  ____  _____  ___  
                 / __\ \_   \/__   \/ _\ || ||___ \|___ / / _ \ 
                / /     / /\/  / /\/\ \| || |_ __) | |_ \| | | |
               / /___/\/ /_   / /   _\ \__   _/ __/ ___) | |_| |
               \____/\____/   \/    \__/  |_||_____|____/ \___/ 
                                                                
                          ___           _           _   
                         / _ \_ __ ___ (_) ___  ___| |_ 
                        / /_)/ '__/ _ \| |/ _ \/ __| __|
                       / ___/| | | (_) | |  __/ (__| |_ 
                       \/    |_|  \___// |\___|\___|\__|
                                     |__/               

Rails: 2.3.8
Ruby: 1.8.7+

--------
#### Concept:
--------

Reddit.com style news aggregation clone specifically for ruby community related news. Similar perhaps to stackoverflow.

This application implements:

- periodically download and cache a number of RSS feeds;
- display the feeds in reverse chronological date; and
- categorise the feeds
- rss feed for the cached feeds
- Downloads images & resizes to fit in 300x250

It has partial testing (primarily unit tests). Also, it has search with suggestions
based on categorisation of stories (storied are automatically categorised).

## Getting Started

To get start, clone / copy the code.

Then, run:

    bundle install
    bundle exec rake db:setup
    bundle exec ./script/server
    
Browse to the site, and login as 'test@test.com' with the password 'password'.

Once you've added a few sites, run `rake updater:update` to force an update of the feeds (in production this would
likely be cronified).

