class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :adress
      t.string :string
      t.datetime :datetime

      t.timestamps null: false
    end
  end
end
