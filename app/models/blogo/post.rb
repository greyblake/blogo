class Blogo::Post < ActiveRecord::Base
  belongs_to :user

  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy

  validates :url, :title,  :raw_content, presence: true

  scope :default,  -> {order("published_at DESC, monologue_posts.created_at DESC, monologue_posts.updated_at DESC") }
  scope :published, -> { where(published: true).where("published_at <= ?", DateTime.now) }

  attr_accessor :tags_string



  def status
    published? ? 'published' : 'draft'
  end


  def tags_string
    @tags_string ||= tags.map(&:name).join(", ")
  end
end
