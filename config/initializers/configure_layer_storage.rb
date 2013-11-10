if ENV['AWS_ACCESS_KEY_ID'] && ENV['AWS_SECRET_ACCESS_KEY'] && ENV['AWS_S3_BUCKET']
  Rails.logger.info "Layer Storage: S3"

  Layer.storage_options = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }
  Layer.storage_bucket = ENV['AWS_S3_BUCKET']

else
  Rails.logger.info "Layer Storage: Local"

  Layer.storage_options = {
    provider: 'Local',
    local_root: Rails.root.join('tmp')
  }
  Layer.storage_bucket = "layer-storage"
end
