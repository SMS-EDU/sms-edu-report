# Service Object to retrieve an uploader
class UploaderFromDB
  def initialize(params)
    @email = params[:email]
  end

  def call
    uploaders = find_uploaders
    return nil if uploaders.empty?
    uploaders.map do |u|
      { id: u.id, email: u.email, phone_number: u.phone_number,
        last_name: u.last_name, first_name: u.first_name,
        school_id: u.school_id }.to_json
    end
  end

  def find_uploaders(results = [])
    Uploader.all.each do |u|
      results << u if u.email == @email
    end
    results
  end
end
