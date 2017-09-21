if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'Google',
      google_storage_access_key_id: ENV['GOOG_ACCESS_KEY'],
      google_storage_secret_access_key: ENV['GOOG_SECRET_KEY']
    }

    config.fog_directory = ENV['GOOG_BUCKET_NAME']
  end
end