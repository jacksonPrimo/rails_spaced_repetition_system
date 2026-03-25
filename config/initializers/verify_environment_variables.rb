if ENV.fetch('RAILS_ENV', 'development') == 'development'
  required = %w[
    DATABASE_URL
    SMTP_ADDRESS
    SMTP_PORT
    SMTP_DOMAIN
    SMTP_USERNAME
    SMTP_PASSWORD
  ].freeze

  missing_envs = required.select { |env| ENV.fetch(env, '').blank? }

  raise "Missing variables: #{missing_envs}" if missing_envs.present?
end
