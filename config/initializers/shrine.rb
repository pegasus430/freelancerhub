require "shrine/storage/s3"

s3_options = {
  access_key_id:     'AKIAIHDI5TKG7NW24O6Q',
  secret_access_key: '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',
  region:            'us-west-2',
  bucket:            'thinkrtc-one',
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", upload_options: {acl: "public-read"}, **s3_options),
  store: Shrine::Storage::S3.new(prefix: "store", upload_options: {acl: "public-read"}, **s3_options),
}

Shrine.plugin :activerecord
Shrine.plugin :direct_upload
Shrine.plugin :restore_cached_data
