class ArticlesController < ApplicationController
  before_action :require_logged_in_user, except: [ :index, :show ]
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]
  before_action :require_article_creator_or_admin, only: [ :edit, :update, :destroy ]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      notice
      redirect_to articles_path
    else
      render "new", status: 422
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      notice
      redirect_to articles_path
    else
      render "edit", status: 422
    end
  end

  def destroy
    @article.destroy
    notice
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, category_ids: [])
  end

  def set_article
    @article = Article.find_by(id: params[:id])
  end

  def require_article_creator_or_admin
    unless (current_user == @article.user) || current_user.admin?
      alert
      redirect_to root_path
    end
  end
end
