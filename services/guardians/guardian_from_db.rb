# Service Object to retrieve an uploader
class GuardianFromDB
  def initialize(params)
    @phone_number = params[:phone_number]
  end

  def call
    guardians = find_guardians
    return nil if guardians.empty?
    guardians.map do |g|
      { phone_number: g.phone_number, guardian_name: g.guardian_name,
        student_name: g.student_name }.to_json
    end
  end

  def find_guardians(results = [])
    Guardian.all.each do |g|
      results << g if g.phone_number == @phone_number
    end
    results
  end
end
