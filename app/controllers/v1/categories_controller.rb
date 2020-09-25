module V1
  class CategoriesController < ApplicationController
    before_action :require_admin, except: %i[index]
    before_action :category, only: %i[show update destroy]

    def index
      @categories = Category.all.order(name: :desc)
      json_response(@categories)
    end

    def create
      @category = Category.create!(category_params)
      json_response(@category, :created) if @category.save!
    end

    def update
      @category.update!(category_params)
      json_response(@category)
    end

    def destroy
      @category.destroy
      head :no_content
    end

    private

    def category_params
      params.permit(:name)
    end

    def require_admin
      raise(ExceptionHandler::InvalidToken, Message.no_admin) unless current_user.admin
    end
  end
end