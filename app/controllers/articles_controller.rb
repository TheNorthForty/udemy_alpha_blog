class ArticlesController < ApplicationController
  # runs method before specified actions; DRY
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  # important to check user before same user to prevent errors if user is false
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new # creates empty article to prevent errors in new.html.erb error check
  end

  def edit
  end

  def create
    # must whitelist what will be allowed to interact with your code
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created successfully"
      #redirect_to article_path(@article)
      redirect_to @article # synsugar
    else
      render 'new'
    end
  end

  def update
    # must whitelist what will be allowed to interact with your code
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article '#{@article.title}' was deleted."
    redirect_to articles_path
  end

  private
  
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end
  
end
