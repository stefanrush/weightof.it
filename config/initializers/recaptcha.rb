Recaptcha.configure do |config|
  config.public_key  = Figaro.env.recaptcha_site_key
  config.private_key = Figaro.env.recaptcha_secret_key
end
