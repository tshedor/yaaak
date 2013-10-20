json.array! @herds do |herd|
  json.id herd.id
  json.geo_lat herd.geo_lat
  json.geo_long herd.geo_long
  json.herd_radius herd.herd_radius
  json.grunts herd.grunts.limit(3) do |grunt|
    json.message grunt.message
    json.user_id grunt.yak.id
    json.user_name grunt.display_name
    json.created_at grunt.created_at
    json.user_color grunt.yak.color
    json.time_ago time_ago_in_words(grunt.created_at)
  end
end
