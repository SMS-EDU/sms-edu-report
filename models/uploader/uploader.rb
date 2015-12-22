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

  def school=(school)
    school = secret_box.encrypt(nonce, school)
    self.encrypted_school = base_64_encode(school)
  end

  def school
    school = base_64_decode(encrypted_school)
    secret_box.decrypt(nonce, school)
  end

  def name=(name)
    name = secret_box.encrypt(nonce, name)
    self.encrypted_name = base_64_encode(name)
  end

  def name
    name = base_64_decode(encrypted_name)
    secret_box.decrypt(nonce, name)
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
