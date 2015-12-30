require_relative '../../lib/methods_for_encryption'

# Getter/setter methods for Student Class
module StudentMethods
  include MethodsForEncryption

  def student_school_id=(student_school_id)
    nonce = RbNaCl::Random.random_bytes(secret_box.nonce_bytes)
    self.encoded_nonce = base_64_encode(nonce)
    student_school_id = secret_box.encrypt(nonce, student_school_id)
    self.encrypted_student_school_id = base_64_encode(student_school_id)
  end

  def student_school_id
    student_school_id = base_64_decode(encrypted_student_school_id)
    secret_box.decrypt(nonce, student_school_id)
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

  def nonce
    base_64_decode(encoded_nonce)
  end
end
