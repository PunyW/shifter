class AddAbbreviationToWorkShift < ActiveRecord::Migration
  def change
    add_column :work_shifts, :abbreviation, :string
  end
end
