# \ -s puma

Dir.glob('./{models,controllers,config}/*.rb')
  .each do |file|
  require file
end

run ApplicationController
