class UserSerializer < ActiveModel::Serializer
  has_many :goals
  attributes :id, :name, :email, :html_url, :is_following, :image_base
  def html_url
    new_html_url = "CLIENT_SIDE_URL/users?user_id=#{object.id}"
  end

  def is_following
    current_user.following?(object)
  end
end
