class CreateBackgroundJobLogs < ActiveRecord::Migration
  def change
    create_table :background_job_logs do |t|
      t.string :job_class, null: false
      t.text :job_arguments
      t.datetime :started_at, null: false
      t.datetime :ended_at
      t.integer :beginning_memory
      t.integer :ending_memory
      t.integer :total_time
      t.boolean :success, null: false, default: false
      t.text :error_message

      t.timestamps
    end
  end
end
