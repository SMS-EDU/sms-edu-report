# Service Object to save uploaders
class SaveGuardiansToDB
  def initialize(params)
    doc = CSV.read(params['file'][:tempfile])
    keys = doc[0]
    values = JSON.parse("#{doc[1..-1]}")
    @guardian_hashes = values.map { |value| keys.zip(value).to_h }
  end

  def call
    @guardian_hashes.each do |guardian_hash|
      guardian = Guardian.new
      guardian.name = guardian_hash['name']
      guardian.phone_number = guardian_hash['phone_number']
      guardian.email = guardian_hash['email']
      guardian.save
    end
  end
end
