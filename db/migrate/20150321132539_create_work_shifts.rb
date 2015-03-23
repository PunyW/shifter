class CreateWorkShifts < ActiveRecord::Migration
  def change
    create_table :work_shifts do |t|
      t.string :name, unique: true
      t.text :description
      t.float :duration
      t.string :start_time
      t.string :end_time

      t.timestamps null: false
    end
  end
end
