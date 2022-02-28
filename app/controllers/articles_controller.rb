class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
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
    if @article.save
      flash[:notice] = "Article was created successfully"
      redirect_to article_path(@article)
    else
      render action: 'new', status: 422
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    pp @article
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully"
      redirect_to article_path(@article)
    else
      render action: 'edit', status: 422
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
      params.require(:article).permit(:title, :description)
    end
end
