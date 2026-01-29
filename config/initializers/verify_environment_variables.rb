if ENV.fetch('RAILS_ENV') == 'development'
  required = %w[
    DB_PORT
    DB_HOST
    DB_USER
    DB_PASSWORD
  ].freeze

  missing_envs = required.select { |env| ENV.fetch(env, '').blank? }

  raise "Missing variables: #{missing_envs}" if missing_envs.present?
end
