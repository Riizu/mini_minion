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
end
