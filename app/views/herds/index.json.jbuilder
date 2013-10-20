json.array! @herds do |herd|
  json.id herd.id
  json.geo_lat herd.geo_lat
  json.geo_long herd.geo_long
  json.grunts herd.grunts.limit(3), :message, :yak
  json.herd_radius herd.herd_radius
end
