class Addr < ActiveRecord::Base
  validates :user_id, :longitude, :latitude, presence: true

  belongs_to :user
end
