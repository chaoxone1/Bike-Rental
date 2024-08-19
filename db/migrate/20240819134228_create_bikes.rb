class CreateBikes < ActiveRecord::Migration[7.1]
  def change
    create_table :bikes do |t|
      t.integer :price
      t.text :description
      t.integer :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
