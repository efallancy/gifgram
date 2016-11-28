# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  caption    :text
#  post_gif   :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
