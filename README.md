This is an example of a Sidekiq-like job system implemented for study using the new parallel approach introduced in Ruby 3 called Ractor.

Dependencies are:

- I'm using the version `ruby 3.0.0-dev 0ac185be40`.
- The project connects to a Redis server. Check out the file `redis_conn.rb` for configuration.

Here is the procedure to run:

- Run the loop: `ruby loop.rb`.
- Enqueue some jobs by executing: `ruby enqueuer.rb`.

Check out [this blog](https://medium.com/@andresakata/background-job-processing-using-ractor-ruby-3-41c7956d14a0) post with more information about how Ractor is being used here.