class FacebookService
  def parse(response)
    JSON.parse(response.body)
  end

  def get_uid(access_token)
    response = Faraday.get("https://graph.facebook.com/debug_token") do |conn|
      conn.params["input_token"] = access_token
      conn.params["access_token"] = "#{ENV['FACEBOOK_KEY']}|#{ENV['FACEBOOK_SECRET']}"
    end

    parse(response)["data"]["user_id"]
  end

  def get_user(uid, access_token)
    response = Faraday.get("https://graph.facebook.com/v2.7/#{uid}") do |conn|
      conn.params["access_token"] = access_token
    end

    parse(response)
  end
end
