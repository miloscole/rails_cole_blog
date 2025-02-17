module ArticlesPaginatable
  extend ActiveSupport::Concern

  included do
    def articles_with_pagination(page, per_page)
      articles
        .paginate(page: page, per_page: per_page)
        .order(created_at: :desc)
        .includes(:user, :categories, :rich_text_content)
    end
  end

  class_methods do
    def with_articles_and_pagination(page, per_page)
      paginate(page: page, per_page: per_page)
        .order(created_at: :desc)
        .includes(:articles)
    end
  end
end
