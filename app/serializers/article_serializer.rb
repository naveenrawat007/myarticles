class ArticleSerializer < ActiveModel::Serializer
  def attributes(*args)
    data = super
    data[:id] = self.object.id
    data[:title] = self.object.title
    data[:body] = self.object.body
    data[:name] = self.object.person.name
    data[:gender] = self.object.person.gender
    data
  end
end
