require_relative '../../lib/methods_for_encryption'

# Getter/setter methods for Uploader Class
module UploaderMethods
  include MethodsForEncryption

  def email=(email)
    nonce = RbNaCl::Random.random_bytes(secret_box.nonce_bytes)
    self.encoded_nonce = base_64_encode(nonce)
    email = secret_box.encrypt(nonce, email)
    self.encrypted_email = base_64_encode(email)
  end

  def email
    email = base_64_decode(encrypted_email)
    secret_box.decrypt(nonce, email)
  end

  def last_name=(last_name)
    last_name = secret_box.encrypt(nonce, last_name)
    self.encrypted_last_name = base_64_encode(last_name)
  end

  def last_name
    last_name = base_64_decode(encrypted_last_name)
    secret_box.decrypt(nonce, last_name)
  end

  def first_name=(first_name)
    first_name = secret_box.encrypt(nonce, first_name)
    self.encrypted_first_name = base_64_encode(first_name)
  end

  def first_name
    first_name = base_64_decode(encrypted_first_name)
    secret_box.decrypt(nonce, first_name)
  end

  def phone_number=(phone_number)
    phone_number = secret_box.encrypt(nonce, phone_number)
    self.encrypted_phone_number = base_64_encode(phone_number)
  end

  def phone_number
    phone_number = base_64_decode(encrypted_phone_number)
    secret_box.decrypt(nonce, phone_number)
  end

  def make_password
    salt = RbNaCl::Random.random_bytes(RbNaCl::PasswordHash::SCrypt::SALTBYTES)
    self.encoded_salt = base_64_encode(salt)
    opslimit = 2**20
    memlimit = 2**24
    result = RbNaCl::PasswordHash.scrypt(email, salt, opslimit, memlimit)
    self.hashed_password = base_64_encode(result)
  end

  def nonce
    base_64_decode(encoded_nonce)
  end
end
