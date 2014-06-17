# Remote Syslog Logger

This library providers an [ActiveSupport][] compatible logger that logs 
directly to a remote syslogd via UDP.

[ActiveSupport]: http://as.rubyonrails.org/


# Installation

The easiest way to install `remote_syslog_logger` is with Bundler. Add
`remote_syslog_logger` to your `Gemfile`.

If you are not using a `Gemfile`, run:

    $ [sudo] gem install remote_syslog_logger


# Usage

Use from Rails:

    config.logger = RemoteSyslogLogger.new('syslog.domain.com', 514, :program => "rails-#{RAILS_ENV}")

Use from Ruby:

    $logger = RemoteSyslogLogger.new('syslog.domain.com', 514)

To point the logs to your local system, use `localhost` and ensure that
the system's syslog daemon is bound to `127.0.0.1`.


# Source

Remote Syslog Logger is available on GitHub, which can be browsed at:

<http://github.com/papertrail/remote_syslog_logger>

and cloned with:

    $ git clone git://github.com/papertrail/remote_syslog_logger.git


# Limitations

If the specified host cannot be resolved, `syslog.domain.com` in the
example under the usage section above, `remote_syslog_logger` will block
for approximately 20 seconds before displaying an error.  This could
result in the application failing to start or even stopping responding.

Workarounds for this include:

* use an IP address instead of a hostname. When logging to Papertrail, 
this would disable any kind of redundancy that would normally be 
achieved via round-robin DNS
* use something like [remote_syslog](https://github.com/papertrail/remote_syslog), 
which is an external application that can monitor log files and 
forward them on to a syslog server


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

Copyright (c) 2011-2014 Eric Lindvall. See [LICENSE][] for details.


[cb]: https://wiki.github.com/defunkt/resque/contributing
[fk]: http://help.github.com/forking/
[is]: https://github.com/papertrail/remote_syslog_logger/issues
[LICENSE]: https://github.com/papertrail/remote_syslog_logger/blob/master/LICENSE
