# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :text
#  name            :text
#  email           :text
#  profile_img     :text
#  biography       :text
#  password_digest :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :comments
end