class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :id_creator
      t.integer :id_location
      t.string :name
      t.string :date
      t.string :duration
      t.string :cathegory
      t.string :description
      t.boolean :privacy

      t.timestamps
    
end
end

end
