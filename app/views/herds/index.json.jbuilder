json.array! @herds do |herd|
  json.id herd.id
  json.grunts herd.grunts, :message, :yak
end
