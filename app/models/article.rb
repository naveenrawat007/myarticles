class Article < ApplicationRecord
  belongs_to :person
  validates :title, :body, presence: true

  def self.get_articles_by_month(date)  
    @articles = Article.where("created_at BETWEEN DATE(?) AND DATE(?)", date.beginning_of_month, date.end_of_month)
    return @articles
  end

  scope :articles_by_date, -> (date) {where("DATE(created_at)= ?", date)}

end
