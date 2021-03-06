class PostsController < ApplicationController
  before_filter :require_user, :only => :create
  # GET /posts
  # GET /posts.json
  def index
    @bad_login = params[:bad_login]
    @user_session = current_user_session
    @user_session ||= UserSession.new
    @posts = Post.order("created_at DESC").page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
      else
        format.html { redirect_to root_path, alert: 'Post failed to be created.' }
      end
    end
  end
end
