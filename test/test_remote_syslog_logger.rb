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
    
    message, _ = *@socket.recvfrom(1024)
    assert_match "This is a test", message
  end

  def test_logger_multiline
    @logger = RemoteSyslogLogger.new('127.0.0.1', @server_port)
    @logger.info "This is a test\nThis is the second line"

    message, _ = *@socket.recvfrom(1024)
    assert_match "This is a test", message

    message, _ = *@socket.recvfrom(1024)
    assert_match "This is the second line", message
  end
end
