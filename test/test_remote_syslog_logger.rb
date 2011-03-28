require File.expand_path('../helper', __FILE__)

class TestRemoteSyslogLogger < Test::Unit::TestCase
  def setup
    @server_port = rand(50000) + 1024
    @socket = UDPSocket.new
    @socket.bind('127.0.0.1', @server_port)
  end
  
  def test_logger
    @logger = RemoteSyslogLogger.new('127.0.0.1', @server_port)
    @logger.info "This is a test"
    
    message, addr = *@socket.recvfrom(1024)
    puts message
    assert_match /This is a test/, message
  end
end