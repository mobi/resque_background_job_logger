require 'test_helper'

# The standard interface for workers with status is to use
# WorkerClass.create instead of Resque.enqueue and pass in
# a hash for arguments. The arguments provided through the job
# is an array. First element is a UUID, second is the hash
# of arguments passed to the worker
class WorkerWithStatusTest < Minitest::Test
  def test_job_adds_one_log_record
    original_count = BackgroundJobLog.count
    worker_class.create
    assert_equal original_count + 1, BackgroundJobLog.count
  end

  def test_log_table_stores_job_class
    worker_class.create
    log = BackgroundJobLog.last
    assert_equal worker_class.to_s, log.job_class
  end

  def test_log_table_stores_job_completion
    worker_class.create
    log = BackgroundJobLog.last
    assert_equal true, log.success
  end

  def test_log_table_stores_arguments
    worker_class.store_arguments
    args = {'arg1' => 1, 'arg2' => 2}
    worker_class.create args
    log = BackgroundJobLog.last
    assert log.job_arguments[0].is_a?(String),
      'First argument of worker with status is not a UUID string'
    assert_equal args, log.job_arguments[1]
  end

  def test_log_table_stores_start_and_end_times
    worker_class.create
    log = BackgroundJobLog.last
    refute log.started_at.nil?, 'started_at was not set'
    refute log.ended_at.nil?, 'ended_at was not set'
    refute log.total_time.nil?, 'total_time was not set'
  end

  private ######################################################################

  def worker_class
    WorkerWithStatus
  end
end
