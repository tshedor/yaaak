json.extract! @herd, :id, :herd_radius, :geo_lat, :geo_long
json.yak_length @herd.yaks.length
json.grunt_length @herd.grunts.length
json.grunts @grunts do |grunt|
  json.message grunt.message
  json.user_id grunt.yak.id
  json.user_name grunt.display_name
  json.created_at grunt.created_at
  json.user_color grunt.yak.color
  json.time_ago time_ago_in_words(grunt.created_at)
  if grunt.photo.exists?
    json.photo_url grunt.photo.url
  end
end