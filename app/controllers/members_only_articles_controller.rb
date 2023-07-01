class MembersOnlyArticlesController < ApplicationController
  before_action :require_login

  def index
    articles = Article.where(is_member_only: true)
    render json: articles
  end

  def show
    article = Article.find(params[:id])
    if article.is_member_only
      render json: article
    else
      render json: { error: "Unauthorized access" }, status: :unauthorized
    end
  end

  private

  def require_login
    unless current_user
      render json: { error: "Unauthorized access" }, status: :unauthorized
    end
  end
end
