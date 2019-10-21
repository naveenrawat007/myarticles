class UserSerializer < ActiveModel::Serializer
  def attributes(*args)
    data = super
    data[:id] = self.object.id
    data[:email] = self.object.email
    data
  end
end
