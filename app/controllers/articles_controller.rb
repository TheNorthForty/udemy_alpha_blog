class ArticlesController < ApplicationController

  def show
    # byebug
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new # creates empty article to prevent errors in new.html.erb error check
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # must whitelist what will be allowed to interact with your code
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      flash[:notice] = "Article was created successfully"
      #redirect_to article_path(@article)
      redirect_to @article # synsugar
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    # must whitelist what will be allowed to interact with your code
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article '#{@article.title}' was deleted."
    redirect_to articles_path
  end
  
end
