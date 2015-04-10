class Picture < ActiveRecord::Base
  validates :url, :twitter_id, :user_id, :status, presence: true
  validates :url, uniqueness: true
  validates :url, :url => { allow_blank: true }

  belongs_to :user
  belongs_to :twitter
end
