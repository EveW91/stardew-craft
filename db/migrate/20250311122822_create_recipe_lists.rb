class CreateRecipeLists < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_lists do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
