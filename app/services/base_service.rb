class BaseService
  def parse(response)
    JSON.parse(response.body)
  end
end
