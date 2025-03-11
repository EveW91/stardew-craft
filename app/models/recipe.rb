class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :recipe_list_recipes
  has_many :recipe_lists, through: :recipe_list_recipes
end
