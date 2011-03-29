# Remote Syslog Logger

This library providers an [ActiveSupport][] compatible logger that logs 
directly to a remote syslogd via UDP.

[ActiveSupport]: http://as.rubyonrails.org/


# Installation

The easiest way to install `remote_syslog_logger` is with RubyGems:

    $ [sudo] gem install remote_syslog_logger


# Usage


Use from Rails:

    config.logger = RemoteSyslogLogger.new('syslog.domain.com', 514, :program => "rails-#{RAILS_ENV}")


Use from Ruby:

    $logger = RemoteSyslogLogger.new('syslog.domain.com', 514)



# Source

Remote Syslog Logger is available on GitHub, which can be browsed at:

<http://github.com/papertrail/remote_syslog_logger>

and cloned with:

    $ git clone git://github.com/papertrail/remote_syslog_logger.git


# Contributing

Once you've made your great commits:

 1. [Fork][fk] `remote_syslog_logger`
 2. Create a topic branch - `git checkout -b my_branch`
 3. Push to your branch - `git push origin my_branch`
 4. Create a Pull Request or an [Issue][is] with a link to your branch
 5. That's it!

You might want to checkout Resque's [Contributing][cb] wiki page for information
on coding standards, new features, etc.


# License

Copyright (c) 2011 Eric Lindvall. See [LICENSE][] for details.


[cb]: https://wiki.github.com/defunkt/resque/contributing
[fk]: http://help.github.com/forking/
[is]: https://github.com/papertrail/remote_syslog_logger/issues
[LICENSE]: https://github.com/papertrail/remote_syslog_logger/blob/master/LICENSE
