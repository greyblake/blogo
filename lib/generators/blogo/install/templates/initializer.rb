Blogo.configure do |config|
  # Edit this to match the subject of your blog
  config.site_title    = 'Blogo'
  config.site_subtitle = 'Mountable blog engine for Ruby on Rails'

  # Supported languages: :html, :markdown
  config.markup_lang = :html

  config.paginator_size = 3
  config.posts_per_page = 10
  config.recent_posts =  3

  # Maybe you do not want to use CKEditor, if you use markdown
  config.use_ckeditor = true

  config.show_rss_icon = true

  # Keywords that will be added automatically to every page
  config.keywords = ["blog"]

  # Do not change this once you installed and ran migrations
  config.table_name_prefix = 'blogo_'

  # Set disqus shortname if you want to your users to have ability to comment
  # your posts.
  #
  # config.disqus_shortname = 'brainv2'


  # Put GOOGLE ANALYTICS ID here, if you want to use Google Analytics
  #
  # config.google_analytics_id = 'GOOGLE_ID'

  # Uncomment and edit if you want to have icon links to github or twitter
  #
  # config.github_username  = 'GITHUB_USERNAME'
  # config.twitter_username = 'TWITTER_USERNAME'
end
