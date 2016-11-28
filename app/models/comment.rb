# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  comment_post :text
#  post_id      :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
end
