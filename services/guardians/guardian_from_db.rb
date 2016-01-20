# Service Object to retrieve a guardian
class GuardianFromDB
  def initialize(params)
    @phone_number = params[:phone_number]
  end

  def call
    guardians = find_guardians
    return nil if guardians.empty?
    guardians.map do |g|
      { id: g.id, name: g.name, phone_number: g.phone_number,
        email: g.email }.to_json
    end
  end

  def find_guardians(results = [])
    Guardian.all.each do |g|
      results << g if g.phone_number == @phone_number
    end
    results
  end
end
