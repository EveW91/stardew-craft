class RecipeList < ApplicationRecord
  belongs_to :user

  has_many :recipe_list_recipes
  has_many :recipes, through: :recipe_list_recipes
end
