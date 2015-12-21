require_relative '../login_security/methods_for_encryption'

# Service Object to retrieve an uploader
class UploaderFromDB
  include MethodsForEncryption

  def initialize(params)
    @email = params[:email]
  end

  def call
    uploaders = find_uploader
    return nil if uploaders.empty?
    uploaders.map do |u|
      nonce = base_64_decode(u.encoded_nonce)
      email = secret_box.decrypt(nonce, base_64_decode(u.encrypted_email))
      school = secret_box.decrypt(nonce, base_64_decode(u.encrypted_school))
      { email: email, school: school }.to_json
    end
  end

  def find_uploader(results = [])
    Uploader.all.each do |u|
      encrypted_email = secret_box.encrypt(
        base_64_decode(u.encoded_nonce), @email)
      results << u if base_64_encode(encrypted_email) == u.encrypted_email
    end
    results
  end
end
