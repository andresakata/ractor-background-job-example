require_relative 'fib_worker'
require_relative 'file_logger'

class Performer
  def initialize
  end

  def perform(worker_id, job)
    klass = job['klass']
    data = job['data']

    log(worker_id, klass, data, 'start')
    result = Object.const_get(klass).new.perform(data)
    log(worker_id, klass, data, result)
  end

  def log(worker_id, klass, data, result)
    FileLogger.log("performer-#{worker_id.to_s}:#{klass}:#{data.to_s}:#{result.to_s}")
  end
end

