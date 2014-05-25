class AddIntToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :id_cathegory, :integer
  end
end
