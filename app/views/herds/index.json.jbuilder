json.array!(@herds) do |herd|
  json.id herd.id
  json.messages herd.yaks do |yak|
    json.message yak.message
  end
end
