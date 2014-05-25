class AddAcceptedToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :accepted, :boolean
  end
end
