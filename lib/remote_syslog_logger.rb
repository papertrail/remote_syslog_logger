
require 'remote_syslog_logger/udp_sender'
require 'logger'

module RemoteSyslogLogger
  VERSION = '1.0.4'

  def self.new(remote_hostname, remote_port, options = {})
    Logger.new(RemoteSyslogLogger::UdpSender.new(remote_hostname, remote_port, options))
  end
end
