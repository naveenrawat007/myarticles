class Article < ApplicationRecord
  belongs_to :person
  validates :title, :body, presence: true

  # def self.get_articles_by_date(date)
  #   @articles = Article.where("DATE(created_at)=?",date)
  #   return @articles
  # end

  scope :articles_by_date, -> (date) {where("DATE(created_at)= ?", date)}

end
