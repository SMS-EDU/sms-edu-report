# Service Object to retrieve an uploader
class SchoolsFromDB
  def initialize(params)
    @name = params[:name]
  end

  def call
    schools = find_schools
    return nil if schools.empty?
    schools.map do |s|
      { id: s.id, name: s.name, phone_number: s.phone_number,
        email: s.email }.to_json
    end
  end

  def find_schools(results = [])
    School.all.each do |s|
      results << s if s.name.downcase.include? @name.downcase
    end
    results
  end
end
