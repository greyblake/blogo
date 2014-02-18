class Blogo::Post < ActiveRecord::Base
  belongs_to :user

  validates :url, :title,  :raw_content, :html_content,
            :markup_format, :published, :published_on,  presence: true
end
