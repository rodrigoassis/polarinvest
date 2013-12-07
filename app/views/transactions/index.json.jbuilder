json.array!(@transactions) do |transaction|
  json.extract! transaction, :investment_id, :date, :transaction_type, :total_value
  json.url transaction_url(transaction, format: :json)
end
