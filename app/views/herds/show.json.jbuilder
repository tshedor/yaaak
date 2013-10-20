json.extract! @herd, :id
json.grunts @herd.grunts do |grunt|
  json.message grunt.message
  json.user_id grunt.yak.id
  json.user_name grunt.display_name
  json.created_at grunt.created_at
  json.user_color grunt.yak.color
end