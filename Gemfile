source 'https://rubygems.org'
ruby '2.2.0'

gem 'sinatra'
gem 'puma'

gem 'activerecord'
gem 'sinatra-activerecord'
gem 'tux'
gem 'hirb'

gem 'config_env'
gem 'rack-ssl-enforcer'
gem 'rbnacl-libsodium'
gem 'protected_attributes'

gem 'jwt'
gem 'httparty'

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

group :test do
  gem 'minitest'
  gem 'minitest-rg'
  gem 'rack'
  gem 'rack-test'
  gem 'rake'
end
