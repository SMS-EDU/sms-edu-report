# Service Object to save uploaders
class SaveUploadersToDB
  def initialize(params)
    doc = CSV.read(params['file'][:tempfile])
    keys = doc[0]
    values = JSON.parse("#{doc[1..-1]}")
    @uploader_hashes = values.map { |value| keys.zip(value).to_h }
  end

  def call
    @uploader_hashes.each do |uploader_hash|
      uploader = Uploader.new
      uploader.email = uploader_hash['email']
      uploader.last_name = uploader_hash['last_name']
      uploader.first_name = uploader_hash['first_name']
      uploader.phone_number = uploader_hash['phone_number']
      uploader.school_id = uploader_hash['school_id']
      uploader.make_password
      uploader.save
    end
  end
end
