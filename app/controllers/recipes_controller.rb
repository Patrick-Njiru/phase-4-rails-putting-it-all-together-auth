class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    before_action :authorize

    def index
        recipes = Recipe.all
        render json: recipes
    end

    def create
        recipe = Recipe.create!(user_id: session[:user_id], **recipe_params)
        render json: recipe, status: :created
    end
    private

    def authorize
        return render json: { errors: ["Not authorized", "Login or Signup to view recipes"] }, status: :unauthorized unless session.include? :user_id
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
