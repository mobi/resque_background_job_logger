require 'test_helper'

class BasicTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ResqueBackgroundJobLogger::VERSION
  end

  def test_job_adds_one_log_record
    original_count = BackgroundJobLog.count
    Resque.enqueue(worker_class)
    assert_equal original_count + 1, BackgroundJobLog.count
  end

  def test_log_table_stores_job_class
    Resque.enqueue(worker_class)
    log = BackgroundJobLog.last
    assert_equal worker_class.to_s, log.job_class
  end

  private ######################################################################

  def worker_class
    BasicWorker
  end
end
