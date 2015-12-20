require_relative '../login_security/methods_for_encryption'

# Service Object to save an uploader
class SaveUploadersToDB
  include MethodsForEncryption

  def initialize(params)
    doc = CSV.read(params['csv'][:tempfile])
    keys = doc[0]
    values = JSON.parse("#{doc[1..-1]}")
    @uploader_hashes = values.map { |value| keys.zip(value).to_h }
  end

  def call
    puts @uploader
    # hashes = @values.map { |value| @keys.zip(value).to_h }
    @uploader_hashes.each do |uploader_hash|
      # puts nonce
      nonce = self.nonce
      salt = self.salt
      uploader = Uploader.new
      save_uploader_to_db(uploader_hash, uploader, nonce, salt)
    end
  end

  # private

  def save_uploader_to_db(uploader_hash, uploader, nonce, salt)
    uploader.encoded_nonce = base_64_encode(nonce)
    uploader.encoded_salt = base_64_encode(salt)
    uploader.encrypted_email = encrypted_email(uploader_hash['id'], nonce)
    uploader.encrypted_school = encrypted_school(uploader_hash['userid'], nonce)
    uploader.hashed_password = hashed_password(uploader_hash['id'], salt)
    uploader.save
  end

  def nonce
    RbNaCl::Random.random_bytes(secret_box.nonce_bytes)
  end

  def encrypted_email(email, nonce)
    base_64_encode(secret_box.encrypt(nonce, email))
  end

  def encrypted_school(school, nonce)
    base_64_encode(secret_box.encrypt(nonce, school))
  end

  def salt
    RbNaCl::Random.random_bytes(RbNaCl::PasswordHash::SCrypt::SALTBYTES)
  end

  def hashed_password(email, salt)
    opslimit = 2**20
    memlimit = 2**24
    result = RbNaCl::PasswordHash.scrypt(email, salt, opslimit, memlimit)
    base_64_encode(result)
  end
end
