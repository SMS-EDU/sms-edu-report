# Service Object to save uploaders
class SaveUploadersToDB
  def initialize(params)
    doc = CSV.read(params['csv'][:tempfile])
    keys = doc[0]
    values = JSON.parse("#{doc[1..-1]}")
    @uploader_hashes = values.map { |value| keys.zip(value).to_h }
  end

  def call
    @uploader_hashes.each do |uploader_hash|
      uploader = Uploader.new
      uploader.email = uploader_hash['email']
      uploader.school = uploader_hash['school']
      uploader.name = uploader_hash['name']
      uploader.make_password
      uploader.save
    end
  end
end
