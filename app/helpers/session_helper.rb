module SessionHelper

  def create_new_yak(lat, long)
    yak = Yak.create(geo_lat: lat, geo_long: long)
    yak.remember_me!
    cookies[:auth_hash] = {
      :value => yak.auth_hash,
      :expires => 1.day.from_now.utc
    }
    cookies[:active_yak] = {
      value: yak.id,
      expires: 1.day.from_now.utc
    }
    yak
  end

  def current_yak=(yak)
    @current_yak = yak
  end

  def current_yak(lat, long)
    @current_yak ||= yak_from_auth_hash
    @current_yak ||= create_new_yak(lat, long)
  end

  def yak_from_auth_hash
    auth_hash = cookies[:auth_hash]
    yak = Yak.find_by_auth_hash(auth_hash) unless auth_hash.nil?
    if yak
    cookies[:auth_hash] = {
        :value => yak.auth_hash,
        :expires => 1.day.from_now.utc
    }
    cookies[:active_yak] = {
        value: yak.id,
        expires: 1.day.from_now.utc
    }
    end
    yak
  end

end
