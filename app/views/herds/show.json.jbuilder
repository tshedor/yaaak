json.extract! @herd, :id
json.grunts @herd.grunts do |grunt|
  json.message grunt.message
  json.user_id grunt.yak.id
  json.user_name grunt.yak.name.split(' ')[1] ? grunt.yak.name.split(' ')[0][0] + grunt.yak.name.split(' ')[1][0] : grunt.yak.name.split(' ')[0][0]
  json.created_at grunt.created_at
  json.user_color grunt.yak.color
end