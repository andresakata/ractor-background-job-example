require 'json'

require_relative 'redis_conn'
require_relative 'performer'

pipe = Ractor.new do
  loop do
    Ractor.yield Ractor.recv
  end
end

WORKERS = 4

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
  p "#{Time.now.to_s}-#{JSON.parse(job[1]).to_s}"
  pipe << JSON.parse(job[1])
end
