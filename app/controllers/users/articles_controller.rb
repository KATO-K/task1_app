module Users
  class ArticlesController < ApplicationController

    # before_action :set_user
    before_action :set_article, only: %i(show edit update destroy)
    before_action :authenticate_user!
    # before_action :correct_user


    def index
      @articles = Article.all
    end
  
    def show
      @article = Article.find(params[:id])
    end

    def new
      @user = User.find(params[:id])
      @article = Article.new
    end

    def create
      @article = Article.new(article_params) 
      unless params[:article][:title] == "" || params[:article][:content] == ""
        @article = @article.update(user_id: params[:id])
        @article = Article.last
        @article.image = "article_#{@article.id}.png"
        File.binwrite("public/images/article_#{@article.id}.png", params[:article][:image].read)
        @article.save
        flash[:success] = "記事を新規作成しました。"
        redirect_to users_articles_url
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @article.update(article_params)
        flash[:success] = "タスクを更新しました。"
        redirect_to users_articles_url
      else
        render :edit
      end
    end
    
    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      flash[:success] = "記事を削除しました。"
      redirect_to users_articles_url
    end

    private

    def article_params
     params.require(:article).permit(:title, :content, :image)
    end
    
    # def set_user
    #   @user = User.find(params[:user_id])
    # end

    def set_article
      @article = Article.find(params[:id])
      unless @article.user_id == current_user.id
        flash[:danger] = "権限がありません。"
        redirect_to user_articles_url @user
      end
    end
    
  end
end