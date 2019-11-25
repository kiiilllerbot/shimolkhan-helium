class PostsController < ApplicationController

  load_and_authorize_resource
  skip_authorize_resource :only => [:upvote, :downvote]

  impressionist :actions=>[:show]

  before_action :set_post, only: [:show, :edit, :update, :destroy,:upvote, :downvote]
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @posts = Post.all.order('created_at DESC').where(["title like ?", "%#{params[:search]}%"]).paginate(page: params[:page], per_page: 12)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order('created_at DESC')
    impressionist @post
  end

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote 
    @post.upvote_by current_user
    redirect_back fallback_location: root_path
  end 

  def downvote
    @post.downvote_by current_user
    redirect_back fallback_location: root_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :user_id, :category_id, :image)
    end
end
