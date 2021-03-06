require "refile/s3"

AWS = {
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region: ENV['AWS_REGION'],
  bucket: ENV['S3_BUCKET'],
}
Refile.cache = Refile::S3.new(prefix: "cache", **AWS)
Refile.store = Refile::S3.new(prefix: "store", **AWS)
