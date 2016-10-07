class BackgroundJobLog < ActiveRecord::Base
  validates :job_class, :started_at, presence: true
  serialize :job_arguments
end
