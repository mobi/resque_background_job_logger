class BasicWorker
  include Resque::Plugins::BackgroundJobLogger
  @queue = :test_queue

  def self.perform
    sleep 1
  end
end

