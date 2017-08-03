class PostsController < ApplicationController
  def index
    @posts=Post.all
  end

  def new
    @post=Post.new
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def create
    # @post = Post.new
    # @post.title = params[:title]
    # @post.contnet = params[:contnet]
    # @post.save
    Post.create(title: params[:post][:title], content: params[:post][:content])
    redirect_to posts_path # method Get
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(title: params[:post][:title], content: params[:post][:content])
    redirect_to '/posts'
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to '/'
  end
end
