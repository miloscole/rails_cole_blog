module ArticlesHelper
  def show_action_buttons?(article)
    logged_in? && (current_user == article.user || current_user.admin?)
  end

  def share_link(platform, article)
    url = article_url(article)
    title = CGI.escape(article.title)

    case platform
    when :facebook
      "https://www.facebook.com/sharer/sharer.php?u=#{url}"
    when :twitter
      "https://twitter.com/intent/tweet?text=#{title}&url=#{url}"
    when :linkedin
      "https://www.linkedin.com/sharing/share-offsite/?url=#{url}"
    else
      "#"
    end
  end
end
