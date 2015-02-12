class ChangeImageSetAgeFromStringToInteger < ActiveRecord::Migration
  def change
    remove_column :image_sets, :age
    add_column :image_sets, :age, :integer
  end
end
