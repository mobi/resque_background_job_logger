module Resque
  module Plugins
    module BackgroundJobLogger
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def store_arguments?
          @store_arguments ||= false
        end

        def store_arguments
          @store_arguments = true
        end

        def track_memory?
          @track_memory ||= false
        end

        def track_memory
          @track_memory = true
        end

        def around_perform_log_worker(*args)
          @worker_log = BackgroundJobLog.new(
            job_class: self.name,
            started_at: Time.now
          )
          @worker_log.job_arguments     = args if store_arguments?
          @worker_log.beginning_memory  = get_process_memory if track_memory?
          @worker_log.save

          yield

          @worker_log.success    = true
          @worker_log.ended_at   = Time.now
          @worker_log.total_time = @worker_log.ended_at - @worker_log.started_at
          @worker_log.ending_memory = get_process_memory if track_memory?
          @worker_log.save
        end

        def on_failure_log_worker(e, *args)
          @worker_log.success       = false
          @worker_log.error_message = e.message
          @worker_log.ended_at      = Time.now
          @worker_log.total_time    = @worker_log.ended_at - @worker_log.started_at
          @worker_log.ending_memory = get_process_memory if track_memory?
          @worker_log.save
        end

        private ###############################################################

        def get_process_memory
          Cocaine::CommandLine.new('ps', "-o rss= -p :pid").run(pid: Process.pid).chomp.to_i
        rescue NameError
          raise 'The cocaine gem is required for memory tracking'
        end

      end
    end
  end
end
