require 'base64'
require 'rbnacl/libsodium'
require 'json'
require 'protected_attributes'

# Helper module for models
module MethodsForEncryption
  def key
    base_64_decode(ENV['DB_KEY'])
  end

  def base_64_encode(value)
    Base64.urlsafe_encode64(value)
  end

  def base_64_decode(value)
    Base64.urlsafe_decode64(value)
  end

  def secret_box
    RbNaCl::SecretBox.new(key)
  end
end
