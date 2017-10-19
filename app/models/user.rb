class User < ApplicationRecord
	has_secure_password
	has_many :goals, :dependent => :destroy
	has_many :comments, :dependent => :destroy
end
