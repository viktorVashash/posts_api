class PostListSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :description,
             :created_at,
             :user

  def initialize(object, user)
    @user = user
    super(object, user)
  end

  def user
    object.user.present? ? UserSerializer.new(object.user) : "User was deleted"
  end
end
