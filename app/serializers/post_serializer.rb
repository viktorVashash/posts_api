class PostSerializer < PostListSerializer
	attributes :id,
             :title,
             :description,
             :created_at,
             :user

  def initialize(object, user)
    @user = user
    super(object, user)
  end

end
