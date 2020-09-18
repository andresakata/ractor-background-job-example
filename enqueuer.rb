require_relative 'fib_worker'

(34..44).each do |n|
  FibWorker.perform_async({ 'n' => n })
end
