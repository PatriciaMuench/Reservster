json.extract! reservation, :id, :date, :time, :party_size, :restaurant_id, :customer_id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
