class UserSerializer < ActiveModel::Serializer
  attributes :id, :uid, :mobile, :email, :avatar
end
