json.extract! bitcoin, :id, :symbol, :user_id, :cost_per, :amount_owned, :created_at, :updated_at
json.url bitcoin_url(bitcoin, format: :json)
