class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|
      t.string :title
      t.belongs_to :foo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
