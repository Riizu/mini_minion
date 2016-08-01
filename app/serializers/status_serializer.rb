class StatusSerializer < ActiveModel::Serializer
  attributes :version, :last_update

  def last_update
    object.created_at.strftime("%m/%d/%Y at %I:%M%p")
  end
end
