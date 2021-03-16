# README

* Ruby 2.5.1

* Rails 5.2.4

* DB postgres

Allow users to submit a URL which will then be shortened
Track the IP address of each visit to a URL

- /              
  -  home page where user can enter a URL
- /:token        
  - redirects to full URL
- /:token/info   
  - info about URL and visitor count
