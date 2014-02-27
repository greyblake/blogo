class Blogo::Post < ActiveRecord::Base
  belongs_to :user

  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy


  validates :permalink, :title,  :raw_content, presence: true
  validates :permalink, uniqueness: true

  scope :published, -> { where(published: true).where("published_at <= ?", Time.now) }

  default_scope { order('published_at DESC') }

  before_save :set_meta_description, :set_meta_image

  def status
    published? ? 'published' : 'draft'
  end

  # Array of tag names. Storing arrays in +tags_string+ we don't need to make
  # many-to-many join with tags table to get tag names.
  #
  # @return [Array<String>]
  def tag_names
    if tags_string
      tags_string.split(',').map(&:strip)
    else
      []
    end
  end


  private

  # Filter html content to get plain text and set first 200 characters as meta_description.
  #
  # @return [void]
  def set_meta_description
    html = html_overiew || html_content

    self.meta_description =
      html.gsub(/<\/?[^>]*>/, ' ').  # replace HTML tags with spaces
           gsub(/&\w{1,9};|"/, '').  # remove HTML special chars and double quotes
           gsub(/\n+/, " ").         # remove new lines
           gsub(/\s+/, ' ').         # remove duplicated spaces
           strip[0..200]             # strip spaces and get first 200 chars
  end

  # Find first img tag and in content and grab its source.
  #
  # @return [void]
  def set_meta_image
    regexp = /<img[^>]+src=["']([^"']*)/
    if img_tag = html_content.match(regexp)
      self.meta_image = img_tag[1]
    end
  end
end
