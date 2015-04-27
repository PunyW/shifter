class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.date :start_date
      t.date :end_date
      t.integer :number
      t.integer :length

      t.timestamps null: false
    end
  end
end
