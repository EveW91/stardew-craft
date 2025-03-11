require 'json'

# Load JSON files
cooking_data = JSON.parse(File.read(Rails.root.join('db', 'data', 'CookingRecipes.json')))
crafting_data = JSON.parse(File.read(Rails.root.join('db', 'data', 'CraftingRecipes.json')))
objects_data = JSON.parse(File.read(Rails.root.join('db', 'data', 'Objects.json')))

# Add special category ingredients manually
special_ingredients = {
  -5 => 'Egg (Any)',
  -6 => 'Milk (Any)'
}

special_ingredients.each do |id, name|
  Ingredient.find_or_create_by!(game_id: id) do |ingredient|
    ingredient.name = name
  end
end

# Seed Ingredients
puts "🌱 Seeding Ingredients..."
objects_data.each do |id, item|
  Ingredient.find_or_create_by!(game_id: id.to_i) do |ingredient|
    ingredient.name = item['Name'].strip
  end
end

# Helper method to extract ingredients from recipe strings
def parse_ingredients(ingredient_string)
  parts = ingredient_string.split('/')
  ingredients = parts[0].strip.split(' ')

  ingredients.each_slice(2).map do |id, amount|
    next if id.nil? || amount.nil?
    { game_id: id.to_i, amount: amount.to_i }
  end.compact
end

# Seed Recipes
puts "🍳 Seeding Recipes..."
cooking_data.each do |recipe_name, details|
  recipe = Recipe.find_or_create_by!(name: recipe_name)
  ingredients = parse_ingredients(details)

  ingredients.each do |ingredient_data|
    ingredient = Ingredient.find_by(game_id: ingredient_data[:game_id])

    if ingredient
      RecipeIngredient.find_or_create_by!(
        recipe: recipe,
        ingredient: ingredient
      ).update(amount: ingredient_data[:amount])
    else
      puts "⚠️ Warning: Ingredient with ID #{ingredient_data[:game_id]} not found for recipe '#{recipe_name}'"
    end
  end
end

puts "✅ Seeding complete!"
