class FacebookService
  def parse(response)
    JSON.parse(response.body)
  end

  def get_access_token(code)
    response = Faraday.get("https://graph.facebook.com/v2.3/oauth/access_token") do |conn|
      conn.params["client_id"] = ENV['FACEBOOK_KEY']
      conn.params["redirect_uri"] = ENV['FACEBOOK_CALLBACK']
      conn.params["client_secret"] = ENV['FACEBOOK_SECRET']
      conn.params["code"] = code
    end
    parse(response)["access_token"]
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
