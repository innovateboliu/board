#$redis = Redis.new(:host => 'localhost', :port=>9999)
#

uri = URI.parse("redis://redistogo:2fe0882bcea756dec5affd1bc80564ab@crestfish.redistogo.com:10009/")
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

