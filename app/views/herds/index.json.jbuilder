json.array!(@herds) do |herd|
  json.extract! herd, :display_name, :genre, :synopsis, :thumb, :seats_available, :seats_sold, :seats_filled, :datemeta_id, :cost
  json.url herd_url(herd, format: :json)
end
