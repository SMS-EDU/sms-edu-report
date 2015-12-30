require_relative '../../lib/methods_for_encryption'

# Getter/setter methods for School Class
module SchoolMethods
  include MethodsForEncryption

  def name=(name)
    nonce = RbNaCl::Random.random_bytes(secret_box.nonce_bytes)
    self.encoded_nonce = base_64_encode(nonce)
    name = secret_box.encrypt(nonce, name)
    self.encrypted_name = base_64_encode(name)
  end

  def name
    name = base_64_decode(encrypted_name)
    secret_box.decrypt(nonce, name)
  end

  def phone_number=(phone_number)
    phone_number = secret_box.encrypt(nonce, phone_number)
    self.encrypted_phone_number = base_64_encode(phone_number)
  end

  def phone_number
    phone_number = base_64_decode(encrypted_phone_number)
    secret_box.decrypt(nonce, phone_number)
  end

  def email=(email)
    email = secret_box.encrypt(nonce, email)
    self.encrypted_email = base_64_encode(email)
  end

  def email
    email = base_64_decode(encrypted_email)
    secret_box.decrypt(nonce, email)
  end

  def nonce
    base_64_decode(encoded_nonce)
  end
end
