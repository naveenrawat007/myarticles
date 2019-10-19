class Article < ApplicationRecord
  belongs_to :person
  validates :title, :body, presence: true
end
