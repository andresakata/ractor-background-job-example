require 'redis'

class RedisConn
  def self.conn
    @@redis ||= Redis.new(password: ENV['REDIS_PASSWORD'])
  end
end
