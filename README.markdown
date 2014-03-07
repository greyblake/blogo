# Blogo

Mountable blog engine for Ruby on Rails 4.

## How it looks like?

<table cellspacing="0">
    <thread>
        <tr>
            <th>Blog</th>
            <th>Admin</th>
        </tr>
    </thread>
    <tbody>
        <tr>
            <td>
                <a href="http://i1078.photobucket.com/albums/w484/greyblake/blogo_mountable_blog_rails_engine.png" target="blog">
                    <img src="http://i1078.photobucket.com/albums/w484/greyblake/th_blogo_mountable_blog_rails_engine.png" border="0" title="Blogo - mountable blog engine for Ruby on Rails" alt="Blogo - mountable blog engine for Ruby on Rails" style=""></a>
                </a>
            </td>
            <td>
                <a href="http://i1078.photobucket.com/albums/w484/greyblake/blogo_admin_mountable_blog_rails_engine.png" target="admin">
                    <img src="http://i1078.photobucket.com/albums/w484/greyblake/th_blogo_admin_mountable_blog_rails_engine.png" border="0" title="Blogo - mountable blog engine for Ruby on Rails(admin)" alt="Blogo - mountable blog engine for Ruby on Rails" style=""></a>
                </a>
            </td>
        </tr>
    </tbody>
</table>


## Quick start


Add the gem to Gemfile of you Rails application:

```
  gem 'blogo'
```

Install the gem:

```
bundle install
```

Install blogo migrations and run them:

```
  rake blogo:install:migrations
  rake db:migrate
```


Create a user:

```
rake blogo:create_user[user_name,user@email.com,password]
```

Mount the blog routes to you rails application in `config/routes.rb`

```
  Blogo::Routes.mount_to(self, at: '/blog')
```

Run the rails application and go to http://localhost:3000/blog/admin to create you first post!

Go to http://localhost::3000/blog to take a look at your posts.


## Features

* Mountable rails engine
* Image upload
* "Read more" feature
* Tags
* Comments with Disqus
* Atom feed
* Pagination
* Designed to support multiple formats(html, markdown, whatever)
* WYSIWYG editor(for html format)
* Google Analytics
* Social icons (Github, Twitter, can be more if you need it)
* SEO optimized: generates meta description, keywords, meta tags for facebook([OpenGraph](http://ogp.me/)) and twitter
* Can be customized for your own needs.
* Very few external dependencies


## Markup Formats


The next formats are supported out of the box, but don't forget to
add necessary dependencies to your Gemfile manually.

| Format   | Dependency |
|----------|------------|
| html     | -          |
| markdown | redcarpet  |


## Credits

* [Sergey Potapov](https://github.com/greyblake) - creator and maintainer

## License

This project rocks and uses MIT-LICENSE.
