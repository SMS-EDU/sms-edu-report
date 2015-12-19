# \ -s puma

Dir.glob('./{models,controllers,services,config}/*.rb')
  .each do |file|
  require file
end

run ApplicationController
