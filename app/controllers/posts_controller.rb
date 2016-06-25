class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    ##@posts = Post.all
    @posts = Post.joins(:infohash_users).where("infohash_users.user_id = ?", current_user.id)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @infohash    = Infohash.new
    @post.infohash = @infohash
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @infohash    = Infohash.new(infohash_params)
    @post        = @infohash.build_post(post_params)

    @infohash.user = current_user
    @infohash.htype_id = 2           # POST
    @infohash.code     = "post" + Post.count.to_s
          
    respond_to do |format|
      if !@infohash.valid?
        @post.valid?
        format.html { render :new }
        format.json { render json: @infohash.errors, status: :unprocessable_entity }
      elsif @post.save
        @infohash.save
        InfohashUser.create(:user => current_user, :infohash => @infohash)
        
        # get hashtags
        lhash  = @infohash.gtitle.scan(/\B#\w+/) #scan(/#\S+/)
        lhash += @infohash.gdescription.scan(/\B#\w+/) #scan(/#\S+/)
        lhash = lhash.uniq     # remove repetitions
        
        # insert only unique
        ActiveRecord::Base.transaction do
          lhash.each do |h|
            Tag.create(:tagname => h.downcase, :infohash => @infohash)
          end
        end

        format.html { redirect_to @post, notice: 'Post was successfully created.' }
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
      params.require(:post).permit(:subject, :message)
    end
    
    def infohash_params
      params.require(:post).permit(:gtitle, :gdescription, :visibility_id)
    end
end
