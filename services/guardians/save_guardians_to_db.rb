require_relative '../login_security/methods_for_encryption'

# Service Object to save uploaders
class SaveGuardiansToDB
  include MethodsForEncryption

  def initialize(params)
    doc = CSV.read(params['csv'][:tempfile])
    keys = doc[0]
    values = JSON.parse("#{doc[1..-1]}")
    @guardian_hashes = values.map { |value| keys.zip(value).to_h }
  end

  def call
    @guardian_hashes.each do |guardian_hash|
      nonce = self.nonce
      guardian = Guardian.new
      save_guardian_to_db(guardian_hash, guardian, nonce)
    end
  end

  def save_guardian_to_db(guardian_hash, guardian, nonce)
    guardian.encoded_nonce = base_64_encode(nonce)
    guardian.encrypted_phone_number = encrypted_phone_number(
      guardian_hash['phone_number'], nonce)
    guardian.encrypted_guardian_name = encrypted_guardian_name(
      guardian_hash['guardian_name'], nonce)
    guardian.encrypted_student_name = encrypted_student_name(
      guardian_hash['student_name'], nonce)
    guardian.save
  end

  def nonce
    RbNaCl::Random.random_bytes(secret_box.nonce_bytes)
  end

  def encrypted_phone_number(phone_number, nonce)
    base_64_encode(secret_box.encrypt(nonce, phone_number))
  end

  def encrypted_guardian_name(guardian_name, nonce)
    base_64_encode(secret_box.encrypt(nonce, guardian_name))
  end

  def encrypted_student_name(student_name, nonce)
    base_64_encode(secret_box.encrypt(nonce, student_name))
  end
end
