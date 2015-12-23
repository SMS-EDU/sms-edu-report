# Service Object to retrieve an uploader
class UploaderFromDB
  def initialize(params)
    @email = params[:email]
  end

  def call
    uploaders = find_uploaders
    return nil if uploaders.empty?
    uploaders.map do |u|
      { email: u.email, school: u.school, name: u.name }.to_json
    end
  end

  def find_uploaders(results = [])
    Uploader.all.each do |u|
      results << u if u.email == @email
    end
    results
  end
end
