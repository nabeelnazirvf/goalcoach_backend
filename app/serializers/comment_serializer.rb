class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :user
  belongs_to :goal

  def user
    user = object.goal.user
  end

  def created_at
    new_created_at = ActionView::Base.new.distance_of_time_in_words(Time.now, object.created_at.to_time).to_s + ' ago'.titleize if object.created_at
    new_created_at
  end

end
