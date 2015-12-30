require_relative '../../lib/methods_for_encryption'

# Getter/setter methods for Record Class
module RecordMethods
  include MethodsForEncryption

  def session=(session)
    nonce = RbNaCl::Random.random_bytes(secret_box.nonce_bytes)
    self.encoded_nonce = base_64_encode(nonce)
    session = secret_box.encrypt(nonce, session)
    self.encrypted_session = base_64_encode(session)
  end

  def session
    session = base_64_decode(encrypted_session)
    secret_box.decrypt(nonce, session)
  end

  def term=(term)
    term = secret_box.encrypt(nonce, term)
    self.encrypted_term = base_64_encode(term)
  end

  def term
    term = base_64_decode(encrypted_term)
    secret_box.decrypt(nonce, term)
  end

  def student_class=(student_class)
    student_class = secret_box.encrypt(nonce, student_class)
    self.encrypted_class = base_64_encode(student_class)
  end

  def student_class
    student_class = base_64_decode(encrypted_class)
    secret_box.decrypt(nonce, student_class)
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
