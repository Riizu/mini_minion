class RiotService < BaseService
  attr_reader :connection

  def initialize
    @connection = Faraday.new("https://na.api.pvp.net/api/lol/")
    @connection.params["api_key"] = ENV["RIOT_API"]
  end

  def versions
    connection = Faraday.new("https://global.api.pvp.net/api/lol")
    response = connection.get("static-data/na/v1.2/versions?api_key=#{ENV['RIOT_API']}")
    parse(response)
  end

  def get_limit_entry
    RateLimit.find_or_create_by(name: "riot") do |r|
      r.limit = "1:10,1:600"
    end
  end

  def handle_limits
    limit_entry = get_limit_entry
    ten_second_check = limit_entry.limit.split(",")[0]
    ten_minute_check = limit_entry.limit.split(",")[1]

    if (ten_second_check == "8:10")
      if ENV['RAILS_ENV'] != "test"
        puts "at rate limits! Pausing!"
        sleep(12)
      else
        reset_limit("seconds", limit_entry)
        return true
      end
      reset_limit("seconds", limit_entry)
    end

    if (ten_minute_check == "590:600")
      if ENV['RAILS_ENV'] != "test"
        puts "at rate limits! Pausing!"
        sleep(600)
      else
        reset_limit("minutes", limit_entry)
        return true
      end
      reset_limit("minutes", limit_entry)
    end
  end

  def reset_limit(type, limit_entry)
    if ENV['RAILS_ENV'] == "test"
      return true
    elsif type == "seconds"
      minutes = limit_entry.limit.split(",")[1]
      limit_entry.update_attributes(limit: "1:10,#{minutes}")
    elsif type == "minutes"
      limit_entry.update_attributes(limit: "1:10,1:600")
    end
  end

  def update_rate_limit(rate_limit)
    limit_entry = get_limit_entry
    limit_entry.update_attributes(limit: rate_limit)
  end
end
