class PersonSerializer < ActiveModel::Serializer
  def attributes(*args)
    data = super
    data[:id] = self.object.id
    data[:name] = self.object.name
    data[:gender] = self.object.gender
    self.object.articles.map do |article|
      data[:title] = article.title
      data[:body] = article.body
    end
    data
  end
end
