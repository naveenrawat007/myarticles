class UserSerializer < ActiveModel::Serializer
  def attributes(*args)
    data = super
    data[:id] = self.object.id
    data[:name] = self.object.name
    data[:email] = self.object.email
    data[:gender] = self.object.gender
    data[:date_of_birth] = self.object.date_of_birth
    data
  end
end
