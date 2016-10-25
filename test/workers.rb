class BasicWorker
  include Resque::Plugins::BackgroundJobLogger
  @queue = :test_queue

  def self.perform(arg1=1, arg2=2)
    sleep 1
  end
end

class WorkerWithStatus
  include Resque::Plugins::Status
  include Resque::Plugins::BackgroundJobLogger
  @queue = :test_queue

  def perform
  end
end
