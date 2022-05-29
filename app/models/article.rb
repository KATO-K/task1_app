class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { in: 1..10 }
  validates :content, presence: true
end