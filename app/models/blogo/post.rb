class Blogo::Post < ActiveRecord::Base
  belongs_to :user

  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy


  validates :url, :title,  :raw_content, presence: true
  validates :url, uniqueness: true

  scope :published, -> { where(published: true).where("published_at <= ?", Time.zone.now) }

  attr_accessor :tags_string

  default_scope { order('published_at DESC') }

  def status
    published? ? 'published' : 'draft'
  end


  def tags_string
    @tags_string ||= tags.map(&:name).join(", ")
  end
end
