class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :actname
      t.string :locname
      t.string :creator
      t.string :catname

      t.timestamps
    end
  end
end
