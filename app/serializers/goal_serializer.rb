class GoalSerializer < ActiveModel::Serializer
  belongs_to :user
  has_many :comments
  attributes :id, :title, :email, :user_id, :created_at, :user

  def created_at
    new_created_at = ActionView::Base.new.distance_of_time_in_words(Time.now, object.created_at.to_time).to_s + ' ago'.titleize if object.created_at
    new_created_at
  end

  def user
    new_user = object.user
    new_user
  end

end
