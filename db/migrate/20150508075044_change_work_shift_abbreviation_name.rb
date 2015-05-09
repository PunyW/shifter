class ChangeWorkShiftAbbreviationName < ActiveRecord::Migration
  def change
    rename_column :work_shifts, :abbreviation, :short_name
  end
end
