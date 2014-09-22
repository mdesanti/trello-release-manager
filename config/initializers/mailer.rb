config = AppConfiguration.for(:mandrill)
ActionMailer::Base.smtp_settings = {
  enable_starttls_auto: true,
  address: 'smtp.mandrillapp.com',
  port: 587,
  domain: config.domain,
  user_name: config.user_name,
  password: config.password,
  authentication: 'login'
}
