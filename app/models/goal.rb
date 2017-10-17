class Goal < ApplicationRecord
  belongs_to :user
  #after_create :public_goal_broadcast
  after_create :notify
  require "net/http"
  has_many :comments, :dependent => :destroy

  def public_goal_broadcast
    #`curl http://localhost:9292/faye -d 'message={"channel":"/messages/new", "data":"#{@goal.title.to_s+','+@goal.email.to_s+','+@goal.id.to_s+','+@goal.created_at.to_s+','+@goal.user_id.to_s}"}'`
    goal = self
    message = {channel: "/messages/new", data: goal}
    begin
      r = Net::HTTP.post_form(URI.parse("http://localhost:9292/faye"), :message => message.to_json)
      if r.code == "200"
        return true
      else
        puts "SOMETHING WENT WRONG!"
      end
    rescue
      puts 'IN RESCUE!'
    end
  end

  def notify
    g = self
    user = g.user
    message = {channel: "/goal_notification", data: {user_name: user.name, image_base: user.image_base, title: g.title, created_at: g.created_at}}
    begin
      r = Net::HTTP.post_form(URI.parse("http://localhost:9292/faye"), :message => message.to_json)
      if r.code == "200"
        return true
      else
        puts "NOTIFY - SOMETHING WENT WRONG!"
      end
    rescue
      puts 'IN RESCUE!'
    end
  end

end
