require 'json'
require_relative 'redis_conn'

module Worker
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def perform_async(data)
      RedisConn.conn.rpush(
        'queue:ractor-example', { 'klass' => self.name, 'data' => data }.to_json
      )
    end
  end
end
