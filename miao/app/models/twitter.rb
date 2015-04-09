class Twitter < ActiveRecord::Base
  validates :user_id, :content, :source, :anonymous, presence: true
  validates :content, length: { in: 0..140 }
  validates :url, :url => {:allow_blank => true}

  belongs_to :user
end
