class CreateShiftWishes < ActiveRecord::Migration
  def change
    create_table :shift_wishes do |t|
      t.integer :employee_id
      t.integer :date_number
      t.integer :month_number
      t.integer :work_shift_id

      t.timestamps null: false
    end
  end
end
