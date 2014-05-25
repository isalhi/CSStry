class CreateUserActs < ActiveRecord::Migration
  def change
    create_table :user_acts do |t|
      t.integer :id_activity
      t.integer :id_user

      t.timestamps
    end
  end
end
