class FileLogger
  def self.log(text)
    file = File.open('logs/output.log', 'a')
    file.write("\n#{Time.now.to_s}-#{text}")
    file.close
  end
end
