class ArticlesController < ApplicationController
    before_action :set_article, only: [ :show, :edit, :update, :destroy ]
    def index
      @articles = Article.all
    end

    def show
    end

    def new
      @article = Article.new
    end

    def create
      article = Article.new(article_params)

      if article.save
        flash[:notice] = "Article was successfully created"
        redirect_to articles_path
      else
        render "new", status: 422
      end
    end

    def edit
    end

    def update
      if @article.update(article_params)
        flash[:notice] = "Article was successfully updated"
        redirect_to articles_path
      else
        render "edit", status: 422
      end
    end

    def destroy
      @article.destroy
      flash[:notice] = "Article was successfully deleted"
      redirect_to articles_path
    end

    private

    def article_params
      params.require(:article).permit(:title, :content)
    end

    def set_article
      @article = Article.find(params[:id])
    end
end
