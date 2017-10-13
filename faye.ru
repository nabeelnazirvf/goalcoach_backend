require 'faye'
require 'logger'
Faye.logger = Logger.new("/home/nnazir/Desktop/nabeel/creative chaos/workspace/api_app_jwt/log/faye.log")

faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
run faye_server

