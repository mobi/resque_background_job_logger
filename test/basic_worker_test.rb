require 'test_helper'

class BasicTest < Minitest::Test
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

  def test_log_table_stores_arguments
    worker_class.store_arguments
    args = [1, 2]
    Resque.enqueue(worker_class, *args)
    log = BackgroundJobLog.last
    assert_equal args, log.job_arguments
  end

  private ######################################################################

  def worker_class
    BasicWorker
  end
end