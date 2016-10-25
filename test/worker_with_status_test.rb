require 'test_helper'

class WorkerWithStatusTest < Minitest::Test
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

  # The standard interface for workers with status is to use
  # WorkerClass.create instead of Resque.enqueue and pass in
  # a hash for arguments. The arguments provided through the job
  # is an array. First element is a UUID, second is the hash
  # of arguments passed to the worker
  def test_log_table_stores_arguments
    worker_class.store_arguments
    args = {'arg1' => 1, 'arg2' => 2}
    worker_class.create args
    log = BackgroundJobLog.last
    assert log.job_arguments[0].is_a?(String),
      'First argument of worker with status is not a UUID string'
    assert_equal args, log.job_arguments[1]
  end

  private ######################################################################

  def worker_class
    WorkerWithStatus
  end
end
