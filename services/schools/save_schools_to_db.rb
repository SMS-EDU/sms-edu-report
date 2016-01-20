# Service Object to save uploaders
class SaveSchoolsToDB
  def initialize(params)
    doc = CSV.read(params['file'][:tempfile])
    keys = doc[0]
    values = JSON.parse("#{doc[1..-1]}")
    @schools_hashes = values.map { |value| keys.zip(value).to_h }
  end

  def call
    @schools_hashes.each do |school_hash|
      school = School.new
      school.name = school_hash['name']
      school.phone_number = school_hash['phone_number']
      school.email = school_hash['email']
      school.save
    end
  end
end
