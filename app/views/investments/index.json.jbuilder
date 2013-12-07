json.array!(@investments) do |investment|
  json.extract! investment, 
  json.url investment_url(investment, format: :json)
end
