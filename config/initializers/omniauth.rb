Rails.application.config.middleware.use OmniAuth::Builder do
  provider :jawbone,
  ENV['JAWBONE_CLIENT_ID'],
  ENV['JAWBONE_CLIENT_SECRET']
end