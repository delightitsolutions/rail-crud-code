class Article < ApplicationRecord
  validates :title, presence: true, length: {minimum: 6,maximum: 100}
  validates :description, presence: true, length: {minimum: 10,maximum: 300}
end

=begin
  rails generate scaffold Article title:string description:text
  rails generate controller pages
  rails generate migration create_articles
  rails generate migration add_timestamps_to_articles
  railsdb:rollback
=end