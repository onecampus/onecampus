class User < ActiveRecord::Base
  validates :uid, :pass, :mobile, presence: true
  validates :pass, length: { in: 4..128 }
  validates :uid, length: { in: 4..20 }
  validates :uid, :mobile, uniqueness: true
end
