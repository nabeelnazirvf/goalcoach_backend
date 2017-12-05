class Goal < ApplicationRecord
  belongs_to :user
  after_create :notify
  require "net/http"
  has_many :comments, :dependent => :destroy

  def public_goal_broadcast
    goal = self
    message = {channel: "/messages/new", data: goal}
    begin
      r = Net::HTTP.post_form(URI.parse("FAYE_SERVER_URL/faye"), :message => message.to_json)
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
      r = Net::HTTP.post_form(URI.parse("FAYE_SERVER_URL/faye"), :message => message.to_json)
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
