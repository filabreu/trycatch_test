class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|
      t.string :title
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
