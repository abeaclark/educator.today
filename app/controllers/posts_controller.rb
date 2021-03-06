class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    case params[:sort]
    when 'newest'
      @posts = Post.paginate(page: params[:page], per_page: 15).order(created_at: :desc)
    else
      @posts = Post.paginate(page: params[:page], per_page: 15).order(score: :desc)
    end

    if current_user
      @votes = current_user.votes
      @posts.map do |post|
        post.update_score
        post.save
        @votes.each do |vote|
          post.current_user_voted = true if vote.post_id == post.id
        end
      end
    end
  end

  def preview
    temporary_attributes = Post.scrape_site(params[:link])
    if temporary_attributes
      @post = Post.new(temporary_attributes)
      render :'_form.html.erb', layout: false if request.xhr?
    else
      flash[:warning] = "Please enter a valid URL"
      redirect '/'
    end
  end


  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to '/?sort=newest'} # , notice: 'Post was successfully created.'
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :vanity_link, :link, :user_id, :upvotes, :score, :summary, :photo_url)
    end
end
