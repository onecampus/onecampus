class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || '邮件格式有误')
    end
  end
end

class User < ActiveRecord::Base

  validates :pass, :mobile, presence: true  # test ok
  validates :pass, length: { in: 4..128 }  # test ok
  validates :uid, length: { in: 4..20, allow_blank: true },  # test ok
                  uniqueness: { allow_blank: true, case_sensitive: false }  # test ok
  validates :mobile, uniqueness: true  # test ok
  validates :email, email: { allow_blank: true },  # test ok
                    uniqueness: { allow_blank: true, case_sensitive: false }  # test ok

  has_many :addrs

  acts_as_followable  # Make your model(s) that you want to allow to be followed acts_as_followable
  acts_as_follower  # Make your model(s) that can follow other models acts_as_follower

  has_many :twitters
  has_many :pictures

  def self.hash_password(pass, salt = 'flowerwrong')
    Digest::SHA256.hexdigest(pass + salt)
  end

  def self.authentication(mobile, pass, salt = 'flowerwrong')
    user = User.where(mobile: mobile).first
    if user && Digest::SHA256.hexdigest(pass + salt) == user.pass
      return user
    end
    nil
  end

  def self.generate_access_token
    SecureRandom.urlsafe_base64(nil, false)
  end
end
