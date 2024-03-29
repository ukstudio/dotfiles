define :dotfile, source: nil do
  source = params[:source] || params[:name]
  directory File.dirname(File.join(ENV['HOME'], params[:name])) do
    user node[:user]
  end
  link File.join(ENV['HOME'], params[:name]) do
    to File.expand_path("../../../config/#{source}", __FILE__)
    user node[:user]
    force true
  end
end
