MUSh
====

A multiple service URL shortener gem with command-line utilities

NOTE: This gem only supports url shortening, nothing else, no stats, no info, no expand and it won't support any of them.

Installation
------------

MUSh depends on [HTTParty](https://github.com/jnunemaker/httparty "HTTParty")
	
	sudo gem install httparty
    sudo gem install mush

or
	
	sudo gem install mush --include-dependencies
	
Supported services
------------------

	* bit.ly
	* is.gd

and thanks to [Noel Dellofano](https://github.com/pinkvelociraptor) from [ZenDesk](http://www.zendesk.com/)

	* ow.ly
	* custom service

Usage as a command line utility
-------------------------------

    $ bitly -l login -k apikey -u http://foo.raflabs.com

    $ isgd http://foo.raflabs.com

    $ owly -k apikey -u foo.raflabs.com

	$ shorten -s "http://chop.ws/index.php?api=1&return_url_text=1&longUrl={{url}}" -u foo.raflabs.com

**NOTE:** _The 'shorten' command uses <code>Mush::Service::Custom</code> and currently it only works with services that accept 'get' as method (not 'post') and with services that return only the shortened url not a full html page_

Sorry, but at this moment, if you want to use the <code>bitly</code> or <code>owly</code> command line without apikey or login do this:

Add the following alias to your ~/.bash_profile or ~/.bashrc

    alias bitly='bitly -l your_login -k your_apikey'
	
	alias owly='owly -k your_apikey'

then use it this way (you won't need the -u)

    $ bitly http://google.com

    $ owly http://google.com

Usage as a Gem
--------------

	require 'rubygems' #in a Rails project you won't need this line
    require 'mush'

    bitly = Mush::Services::Bitly.new

    bitly.login = "login"
    bitly.apikey = "apikey"

    bitly.shorten "http://foo.raflabs.com"

    isgd = Mush::Services::IsGd.new
    isgd.shorten "http://foo.raflabs.com"

	custom = Mush::Services::Custom.new
	custom.set_service = "http://chop.ws/index.php?api=1&return_url_text=1&longUrl={{url}}"
	custom.shorten 'foo.raflabs.com'
	
ToDo
----

* Use bitly commmand without -l and -k, save config in home folder (.mush file)
* Make shorten method to accept multiple URLs
* add j.mp and maybe other services
* Cache

Note on Patches/Pull Requests
-----------------------------
 
* Fork the project.
* Make your feature/service addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2011 Rafael Magana. See LICENSE for details.