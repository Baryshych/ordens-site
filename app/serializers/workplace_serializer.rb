class WorkplaceSerializer < ActiveModel::Serializer
  attributes :id, :title, :address

  def address
    object.address.present? ? object.address : nil
  end
end
