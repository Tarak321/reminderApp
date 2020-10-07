json.extract! user, :id, :email, :name, :email_address, :contact_number, :country, :date_of_birth,:blood_group,:weight,:height, :created_at, :updated_at
json.url user_url(user, format: :json)
json.profile_image rails_blob_url(user.profile_image) if user.profile_image.present?
json.profile_image2 @direct_url if user.profile_image.present?

