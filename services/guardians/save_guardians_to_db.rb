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
      guardian.phone_number = guardian_hash['phone_number']
      guardian.guardian_name = guardian_hash['guardian_name']
      guardian.student_name = guardian_hash['student_name']
      guardian.save
    end
  end
end
