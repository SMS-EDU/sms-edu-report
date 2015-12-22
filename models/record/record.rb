require_relative '../../lib/methods_for_encryption'

# Getter/setter methods for Record Class
module RecordMethods
  include MethodsForEncryption

  def uploader_email=(uploader_email)
    nonce = RbNaCl::Random.random_bytes(secret_box.nonce_bytes)
    self.encoded_nonce = base_64_encode(nonce)
    uploader_email = secret_box.encrypt(nonce, uploader_email)
    self.encrypted_uploader_email = base_64_encode(uploader_email)
  end

  def uploader_email
    uploader_email = base_64_decode(encrypted_uploader_email)
    secret_box.decrypt(nonce, uploader_email)
  end

  def record_json=(record_json)
    record_json = secret_box.encrypt(nonce, record_json)
    self.encrypted_record_json = base_64_encode(record_json)
  end

  def record_json
    record_json = base_64_decode(encrypted_record_json)
    secret_box.decrypt(nonce, record_json)
  end

  def nonce
    base_64_decode(encoded_nonce)
  end
end
