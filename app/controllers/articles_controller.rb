class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_user, expect: %i[show, index]
  before_action :require_same_user, only: %i[edit update destroy]

  # GET /articles or /articles.json
  def index
    @articles = Article.paginate(page: params[:page], per_page: ARTICLES_PAGINATION_LIMIT).order('id DESC')
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    set_article
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article was created successfully'
      redirect_to article_path(@article)
    else
      render action: 'new', status: UNPROCESSABLE_ENTITY_STATUS
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    if @article.update(article_params)
      flash[:success] = 'Article was updated successfully'
      redirect_to article_path(@article)
    else
      render action: 'edit', status: UNPROCESSABLE_ENTITY_STATUS
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:id, :title, :description)
  end

  def require_same_user
    if current_user != @article.user
      flash[:warning] = 'You cannot edit this article because it is not yours!'
      redirect_to @article
    end

  end
end
