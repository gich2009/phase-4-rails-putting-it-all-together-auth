class RecipesController < ApplicationController
  def index
    user = User.find_by(id: session[:user_id])

    if user
      recipes = user.recipes
      render json: recipes
    else
      render json: { errors: ["Not authorized"] }, status: :unauthorized
    end
  end

  def create
    user = User.find_by(id: session[:user_id])

    if user
      recipe = user.recipes.build(recipe_params)

      if recipe.save
        render json: recipe, status: :created
      else
        render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: ["Not authorized"] }, status: :unauthorized
    end
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end


end

