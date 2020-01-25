class Api::V1::PostsController < Api::ApiController
  before_action :authenticate
  before_action :init_post, except: [:create]

  def index
      posts = PostService.new(params, @current_user).filter_process
      posts = Kaminari.paginate_array(posts).page(params[:page]).per(params[:per_page])
      render json: { posts: posts.map { |item| PostListSerializer.new(item, @current_user) }, total_pages: posts.total_pages }
  end

  def create
    @post = Post.new(post_params.merge(user_id: @current_user.id))
    if @post.save
      render json: { post: PostSerializer.new(@post, @current_user) }, status: 200
    else
      render json: { error_messages: @post.errors.messages}, status: 400
    end
  end

  def update
    if @post&.update(update_post_params)
       render json: { post: PostSerializer.new(@post, @current_user) }, status: 200
      else
        render json: { error_messages: @post.errors.messages}, status: 400
      end
  end

  def destroy
    if @post&.destroy
      render json: { message: "Post deleted" }, status: 200
    else
      render json: { message: "Post not found"}, status: 404
    end
  end

  def show
    if @post
      PostView.find_or_create_by(user_id: @current_user.id, post_id: @post.id)
      render json: { post: PostSerializer.new(@post, @current_user) }, status: 200
    else
      render json: { error_messages: "Post not found"}, status: 404
    end
  end

  private

  def init_post
    @post = Post.find_by_id(params[:id])
  end

  def post_params
    params.required(:post).permit(:user_id, :title, :description)
  end

  def update_post_params
    params.required(:post).permit(:title, :description)
  end

end
