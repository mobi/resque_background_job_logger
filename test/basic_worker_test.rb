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

  def test_log_table_stores_job_completion
    Resque.enqueue(worker_class)
    log = BackgroundJobLog.last
    assert_equal true, log.success
    assert log.error_message.nil?, 'error_message was set and should not have'
  end

  def test_log_table_stores_arguments
    worker_class.store_arguments
    args = [1, 2]
    Resque.enqueue(worker_class, *args)
    log = BackgroundJobLog.last
    assert_equal args, log.job_arguments
  end

  def test_log_table_stores_start_and_end_times
    Resque.enqueue(worker_class)
    log = BackgroundJobLog.last
    refute log.started_at.nil?, 'started_at was not set'
    refute log.ended_at.nil?, 'ended_at was not set'
    refute log.total_time.nil?, 'total_time was not set'
  end

  private ######################################################################

  def worker_class
    BasicWorker
  end
end
