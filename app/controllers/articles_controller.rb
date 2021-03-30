class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :require_user, except: [:show, :index]
  before_action :req_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page])
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created successfully!"
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully!"
      redirect_to @article
    else
      'edit'
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

    def req_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:alert] = 'You can only edit or view your own article'
        redirect_to @article
      end
    end
end
