class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :email, :password_digest, :admin, :image, :isDoctor
  def image
    return unless object.image.attached?

    {
      url: rails_blob_url(object.image)
    }
  end
end
