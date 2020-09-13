require 'logger'
require 'json'

require_relative 'fib_worker'

class Performer
  def initialize
  end

  def perform(worker_id, job)
    result = Object.const_get(job['klass']).new.perform(job['data'])
    log(worker_id, job, result)
  end

  def log(worker_id, job, result)
    @file = File.open('output.log', 'a')
    @file.write("\n#{Time.now.to_s}-#{worker_id.to_s}:#{job['klass']}:#{job['data'].to_s}:#{result.to_s}")
    @file.close
  end
end

