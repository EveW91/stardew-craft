class CreateRecipeListRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_list_recipes do |t|
      t.references :recipe_list, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
