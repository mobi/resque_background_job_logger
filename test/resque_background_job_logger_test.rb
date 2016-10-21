require 'test_helper'

class BaseWorker
  include Resque::Plugins::BackgroundJobLogger
  @queue = :test_queue

  def self.perform
  end
end

class ResqueBackgroundJobLoggerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ResqueBackgroundJobLogger::VERSION
  end

  def test_job_adds_one_log_record
    original_count = BackgroundJobLog.count
    Resque.enqueue(BaseWorker)
    assert_equal original_count + 1, BackgroundJobLog.count
  end

end
