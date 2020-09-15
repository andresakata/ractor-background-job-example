require_relative 'worker'

class FibWorker
  include Worker

  def perform(data)
    fib(data['n'])
  end

  def fib(n)
    if n <= 1
      n
    else
      fib(n - 1) + fib(n - 2)
    end
  end
end
