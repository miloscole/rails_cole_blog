class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  before_action :require_admin, except: %i[index show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 6)
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 4)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      notice
      redirect_to categories_path
    else
      render "new", status: 422
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      notice
      redirect_to category_path(@category)
    else
      render "edit", status: 422
    end
  end

  def destroy
    @category.destroy
    notice
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
