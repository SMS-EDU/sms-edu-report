# Service Object to retrieve an uploader
class GuardianFromDB
  def initialize(params)
    @phone_number = params[:phone_number]
  end

  def call
    uploaders = find_uploader
    return nil if uploaders.empty?
    uploaders.map do |u|
      { phone_number: u.phone_number, guardian_name: u.guardian_name,
        student_name: u.student_name }.to_json
    end
  end

  def find_uploader(results = [])
    Guardian.all.each do |u|
      results << u if u.phone_number == @phone_number
    end
    results
  end
end
