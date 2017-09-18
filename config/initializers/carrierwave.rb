if Rails.env.production?
  Carrierwaveconfigure do |config|
    config.fog_credentails = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY']
    }

    config.flog_directory = ENV['S3_BUCKET_NAME']
  end
end