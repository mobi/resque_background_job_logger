$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'resque_background_job_logger'

require 'minitest/autorun'
require 'minitest/pride'
require 'resque'

require 'workers'

Resque.inline = true

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
ActiveRecord::Schema.verbose = false
ActiveRecord::Migrator.up(['lib/generators/resque_background_job_logger/install/templates'])


