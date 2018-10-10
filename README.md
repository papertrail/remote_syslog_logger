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

    config.logger = RemoteSyslogLogger.new('syslog.domain.com', 514,
                      :program => "rails-#{RAILS_ENV}",
                      :local_hostname => "optional_hostname")

With Rails 3+ if you want to use tagged logging wrap in a `TaggedLogging` instance:

    config.logger = ActiveSupport::TaggedLogging.new(
                      RemoteSyslogLogger.new(
                        'syslog.domain.com', 514,
                        :program => "rails-#{RAILS_ENV}",
                        :local_hostname => "optional_hostname"
                      )
                    )

Use from Ruby:

    require 'remote_syslog_logger'
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

* use an IP address instead of a hostname.
* put a hosts entry in `/etc/hosts` or equivalent, so that DNS is not
actually consulted
* instead of logging directly to the network, write to a file and
transmit new entries with a standalone daemon like
[remote_syslog](https://github.com/papertrail/remote_syslog),

## Message length

All log lines are truncated to a maximum of 1024 characters. This restriction
comes from [RFC 3164 section 4.1][rfc-limit]:

> The total length of the packet MUST be 1024 bytes or less.

Additionally, the generally-accepted [MTU][] of the Internet is 1500 bytes, so
regardless of the RFC, UDP syslog packets longer than 1500 bytes would not
arrive. For details or to use TCP syslog for longer messages, see
[help.papertrailapp.com][troubleshoot].

There is a `max_size` option to override this restriction, but it should only be
used in extraordinary circumstances. Oversize messages are more likely to be
fragmented and lost, with some receivers rejecting them entirely.

[rfc-limit]: https://tools.ietf.org/html/rfc3164#section-4.1
[MTU]: (https://en.wikipedia.org/wiki/Maximum_transmission_unit)
[troubleshoot]: http://help.papertrailapp.com/kb/configuration/troubleshooting-remote-syslog-reachability/#message-length


## Default program name

By default, the `program` value is set to the name and ID of the invoking
process. For example, `puma[12345]` or `rack[3456]`.

The `program` value is used to populate the syslog "tag" field, must be 32
or fewer characters. In a few cases, an artifact of how the app is launched
may lead to a default `program` value longer than 32 characters. For example,
the `thin` Web server may generate a default `program` value such
as:

    thin server (0.0.0.0:3001)[11179]

If this occurs, the following exception will be raised when a
`RemoteSyslogLogger` is instantiated:

    Tag must not be longer than 32 characters (ArgumentError)

To remedy this, explicitly provide a `program` argument which is shorter than
32 characters. See [Usage](#usage).


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

Copyright (c) 2011-2016 Eric Lindvall. See [LICENSE][] for details.


[cb]: https://wiki.github.com/defunkt/resque/contributing
[fk]: http://help.github.com/forking/
[is]: https://github.com/papertrail/remote_syslog_logger/issues
[LICENSE]: https://github.com/papertrail/remote_syslog_logger/blob/master/LICENSE
