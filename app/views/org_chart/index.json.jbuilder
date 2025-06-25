json.data do
  json.array! @nodes do |node|
    json.id node[:id]
    json.name node[:name]
    json.title node[:title]
    json.pid node[:pid]
    Rails.logger.debug "Rendering node: #{node[:name]}"
  end
end