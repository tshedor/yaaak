json.user_id @yak.id
json.created_at @yak.created_at
json.user_name @yak.name
json.short_user_name @yak.name.split(' ')[1] ? @yak.name.split(' ')[0][0] + @yak.name.split(' ')[1][0] : @yak.name.split(' ')[0][0]
json.user_color @yak.color
json.grunt_count @yak.grunts.length
json.last_grunt @yak.grunts[0].message