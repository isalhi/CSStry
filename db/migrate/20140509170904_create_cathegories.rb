class CreateCathegories < ActiveRecord::Migration
  def change
    create_table :cathegories do |t|
      t.string :name

      t.timestamps
    end
  end
end
