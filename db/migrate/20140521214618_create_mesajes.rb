class CreateMesajes < ActiveRecord::Migration
  def change
    create_table :mesajes do |t|
      t.integer :id_creator
      t.integer :id_activity
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
