class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || '邮件格式有误')
    end
  end
end

class User < ActiveRecord::Base
  validates :uid, :pass, :mobile, presence: true
  validates :pass, length: { in: 4..128 }
  validates :uid, length: { in: 4..20 }
  validates :uid, :mobile, uniqueness: true

  def self.hash_password(pass, salt)
    Digest::SHA256.hexdigest(pass + salt)
  end

  def self.authentication(email, pass, salt)
    user = User.where(email: email).first
    if user && Digest::SHA256.hexdigest(pass + salt) == user.password
      return user
    end
    nil
  end

  def self.generate_access_token
    SecureRandom.urlsafe_base64(nil, false)
  end
end
