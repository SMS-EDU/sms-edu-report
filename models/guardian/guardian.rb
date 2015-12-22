require_relative '../../lib/methods_for_encryption'

# Getter/setter methods for Guardian Class
module GuardianMethods
  include MethodsForEncryption

  def phone_number=(phone_number)
    nonce = RbNaCl::Random.random_bytes(secret_box.nonce_bytes)
    self.encoded_nonce = base_64_encode(nonce)
    phone_number = secret_box.encrypt(nonce, phone_number)
    self.encrypted_phone_number = base_64_encode(phone_number)
  end

  def phone_number
    phone_number = base_64_decode(encrypted_phone_number)
    secret_box.decrypt(nonce, phone_number)
  end

  def guardian_name=(guardian_name)
    guardian_name = secret_box.encrypt(nonce, guardian_name)
    self.encrypted_guardian_name = base_64_encode(guardian_name)
  end

  def guardian_name
    guardian_name = base_64_decode(encrypted_guardian_name)
    secret_box.decrypt(nonce, guardian_name)
  end

  def student_name=(student_name)
    student_name = secret_box.encrypt(nonce, student_name)
    self.encrypted_student_name = base_64_encode(student_name)
  end

  def student_name
    student_name = base_64_decode(encrypted_student_name)
    secret_box.decrypt(nonce, student_name)
  end

  def nonce
    base_64_decode(encoded_nonce)
  end
end
