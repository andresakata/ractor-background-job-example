require 'json'

require_relative 'redis_conn'
require_relative 'performer'
require_relative 'file_logger'

pipe = Ractor.new do
  loop do
    job = Ractor.recv
    FileLogger.log("pipe-recv-#{job.to_s}")
    Ractor.yield job
  end
end

WORKERS = 3

workers = (1..WORKERS).map do |worker_id|
  Ractor.new(worker_id, pipe) do |worker_id, pipe|
    loop do
      job = pipe.take
      Performer.new.perform(worker_id, job)
    end
  end
end

loop do
  job = RedisConn.conn.blpop(['queue:ractor-example'], 1)
  next if job.nil?
  FileLogger.log("redis-blpop-#{job[1].to_s}")
  pipe << JSON.parse(job[1])
end
