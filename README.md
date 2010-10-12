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

------------
#### Differences:
------------


Realtime chat on aggregated or voted up news topics.

--------------------
Stage I Requirement:
--------------------

This part of the project is worth 10% of the total Unit marks and will be assessed against the following criteria:

* A total of at least 5 pages to meet your site purpose.
* Your website must support Internet Explorer, Firefox and Opera, under the version used in our Lab Linux system. You will receive 1% Bonus mark if it is XHTML1.1 Strict and CSS12.1 valid. Display the validation logo and the link to the validation results.
* Site Structure
 - The site should implement a mixed structure, main pages to be linked in a hiearachical structure
 - Pages naturally forms a linear chain should be connected using a linear structure.
* Navigational aids
 - Site Map
 - Navigation bars on every page
* Aesthetics
 - The site should have a consistent look and feel (make sure you use external style sheets for formatting)
 - While maintain a sense of belonging to the site, each page has to be different to show locality so readers know they are on the same site but browsing different pages (make sure you use inline and embedded styles)
 - The design theme should agree with the site purpose and meet the needs and taste of potential audience
 - Most importantly, make sure the foreground and background are contrasting well and good typography is used
 - Sensible use of images and other multi-media formats.
* Hyperlinks
Use relative URLs to ensure portability
 - Make sure no broken images or broken links
* Appropriate use the following techniques and provide a README file (can be in plain text) to document the rationale and how you used them. This README file should also help the project marker to locate which pages contain the required technique.
* Form Controls
* CSS
* Client-side Programming: Javascript - at least for basic form validation
* Due to possible incompability between browsers on rendering CSS positioning, page layout using tables is allowedPage Layout needs to be done by CSS positioning, no layout tables are allowed..
* Use of free images, free website template, free video clips and multimedia files obtained from the Web is permitted, but you will need to provide a separate Reference Page for the site (in addition to the 5+ required pages). Copyright materials must get permission before use.

-----------------
Stage II Requirement:
-----------------

The aim of this project is to build a database driven web application, using Ruby on Rails, HTML, CSS and JavaScript. Each group must pick one of the projects listed below.

Each project has a baseline worth 85% in which every requirement must be attempted, a second set of requirements which are recommended worth an additional 5%.

10% of marks will be given code test coverage, measured using the coverage tool: Rcov. Rcov will tell you what percentage of your code base is tested. For every 10% of coverage, you will get 1%. To get the full 10%, you will need 100% test coverage, with all tests passing.

It is possible to achieve 10% bonus marks for this project. 2% of the bonus marks will be awarded if the site is built in valid HTML5 and CSS3 (vendor-specific extensions WILL BE allowed). The remaining 8% of the bonus requirements require independent research as they won't be covered in the lecture material.

---------
#### Tools
----------

In addition to using Ruby on Rails, which will be covered in the lectures, it is also recommended that you consider using the popular open source code management (or version control) system Git. While CSSE will be setting up git repositories for you, have a read of the Github help files: http://help.github.com/ as they have a good getting started guide. If have any questions, please ask them on help4230.

If you are unable to meet in person, you can try out some of the online project management tools, such as Basecamp and Campfire.

---------------
### Deliverables
---------------

The deliverables for stage II of this project are as follows:

* A working Rails (version 2.3.x) site, that:

 - has an up-to-date schema.rb file
 - describes all required gems (including version where applicable) in config/environment.rb (or via Bundler)
 - has few (preferably no) external service dependencies (ie use acts_as_indexable not sphinx). Dependencies that are ok: memcache, mysql, cron.
 - has a README file that describes setup steps.
 - A working set of unit tests.

Documentation that should consist of:

 * Functionality and Design Decisions (max. 2 pages)

   - What functionality was included in the final product? What was left out? What design decisions were made that had a bearing on the final functionality?

 * Review and Further Development (max. 2 pages)

   - This section provides an opportunity to critically reflect on your team's development process, what you learnt, how you might do things differently next time, and where you would take the project given more time.

The documentation should be submitted to cssubmit in PDF format. You should check that your document can be opened and read in the Preview application on the Macs. You may also include a copy of the document in your group directory.

------------------
### A news aggregator
-------------------

There is so much information out there on the Internet, that aggregation services are can be really helpful disseminating information on a particular topic. Now that many sites syndicate their data via RSS and webservices, building news aggregator is quite simple.

#### Baseline (85%)

* The system should:

 - periodically download and cache a number of RSS feeds;
 - display the feeds in reverse chronological date; and
 - categorise the feeds

#### Full Marks (100%)

* The system should:

 - download any associated images with the stream, resize them and display them as part of the story;
 - add an RSS feed of the cached feeds; and
 - have complete unit and functional/integrations tests (10%)

#### Bonus marks (110%)

To get the bonus marks for this project, the system should include indexed full text search, allowing users to search the cached feeds for keywords. The system should also make â€œYou may also likeâ€ suggestions (8%). Building the site using HTML5 and CSS3 is worth an additional 2%.

----------------------------
#### Specification Updates

The project and any changes will be discussed further in the lectures.

Any specification updates or clarifications will be notified on help4230. You are responsible for checking this regularly. (It is suggested that you set your preferences so that you are sent an email of any postings on help4230.)


