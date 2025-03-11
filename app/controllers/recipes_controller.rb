class RecipesController < ApplicationController
  def index
    @recipes = Recipe.includes(:ingredients).all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def search
    if params[:recipe_search].present?
      query = "%#{params[:recipe_search].downcase}%"
      @recipes = Recipe.where("LOWER(name) ILIKE ?", query)
    else
      @recipes = Recipe.all
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("results", partial: "recipes/results", locals: { recipes: @recipes })
      end
    end
  end
end
