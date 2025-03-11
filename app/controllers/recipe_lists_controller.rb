class RecipeListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipe_lists = current_user.recipe_lists
  end

  def show
    @recipe_list = RecipeList.find(params[:id])
    @recipes = @recipe_list.recipes
  end

  def new
    @recipe_list = RecipeList.new
  end

  def create
    @recipe_list = current_user.recipe_lists.new(recipe_list_params)
    if @recipe_list.save
      redirect_to recipe_lists_path, notice: "New recipe list created"
    else
      render :new
    end
  end

  def edit
    @recipe_list = RecipeList.find(params[:id])
  end

  def update
    if @recipe_list.update(recipe_list_params)
      redirect_to @recipe_list, notice: "Recipe list updated"
    else
      render :edit
    end
  end

  def destroy
    @recipe_list = RecipeList.find(params[:id])
    @recipe_list.destroy

    redirect_to recipe_lists_path, notice: "List deleted", status: :see_other
  end

  def add_recipe
    @recipe_list = RecipeList.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])

    unless @recipe_list.recipes.include?(@recipe)
      @recipe_list.recipes << @recipe
      redirect_to @recipe_list, notice: "Recipe added to list!"
    else
      redirect_to @recipe_list, alert: "Recipe already in list"
    end
  end

  private

  def recipe_list_params
    params.require(:recipe_list).permit(:name, :notes)
  end
end
