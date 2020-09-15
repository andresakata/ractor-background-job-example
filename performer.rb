require_relative 'fib_worker'
require_relative 'file_logger'

class Performer
  def initialize
  end

  def perform(worker_id, job)
    result = Object.const_get(job['klass']).new.perform(job['data'])
    log(worker_id, job, result)
  end

  def log(worker_id, job, result)
    FileLogger.log("#{worker_id.to_s}:#{job['klass']}:#{job['data'].to_s}:#{result.to_s}")
  end
end

