json.array!(@assets) do |asset|
  json.extract! asset, 
  json.url asset_url(asset, format: :json)
end
