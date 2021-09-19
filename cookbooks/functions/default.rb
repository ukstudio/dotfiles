define :dotfile, source: nil do
  source = params[:source] || params[:name]
  p source
  p File.join(ENV['HOME'], params[:name])
  p File.expand_path("../../../config/#{source}", __FILE__)
  link File.join(ENV['HOME'], params[:name]) do
    to File.expand_path("../../../config/#{source}", __FILE__)
    user node[:user]
    force true
  end
end
