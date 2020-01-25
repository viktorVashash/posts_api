class PostService

  def initialize(options, user)
    @user = user
    @title = options[:title]
    @posts = Post.order(created_at: :asc)
  end

  def filter_process
    title_search          if @title.present?
    @posts
  end

  def title_search
    @posts = @posts.select{ |item| item if  item.title.downcase.include?(@title.downcase) }
  end
end
