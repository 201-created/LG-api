class ConvertAgeToDatetime < ActiveRecord::Migration
  def change
    remove_column :lions, :age
    add_column :lions, :age, :datetime
  end
end
