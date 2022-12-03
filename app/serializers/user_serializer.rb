class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password_digest, :password_confirmation_digest, :image_url, :bio
end
