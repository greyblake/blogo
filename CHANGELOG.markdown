# v0.1.3 2015-12-20

* [feature] Chinese localization (jokester)
* [feature] Spanish localization (taniadaniela)

# v0.1.2 2015-11-28

* [fixed] fix routing bug in development env, issue #3 (greyblake)

# v0.1.1 2015-03-30

* [changed] replace dependency bcrypt-ruby with bcrypt (greyblake)

# v0.1.0 2015-03-29

* [fixed] Fix delete post bug (greyblake)
* [fixed] Compatibility with rails 4.2 (greyblake)

# v0.0.10 2014-10-27

* [feature] Generator blogo:install to install intializer (greyblake)
* [changed] Add link "Powered by Blogo" for the default layout (greyblake)

# v0.0.9 2014-06-08

* [feature] Localization support: en, pt-BR (diegosouza)

# v0.0.8 2014-05-13

* [fixed] Fix post preview error (greyblake)

# v0.0.7 2014-03-19

* [changed, fixed] Rename column with typo html_overiew -> html_overview (greyblake)
* [feature] Add good test coverage (greyblake)
* [changed] Number of partial templates were rearranged (greyblake)

# v0.0.6 2014-03-13

* [fixed] Make canonical URL do not cause error (greyblake)

# v0.0.5 2014-03-13

* [feature] Add canonical URL (greyblake)
* [feature] Add links for social sharing (greyblake)

# v0.0.4 2014-03-08

* [changed] Use `public/system/blog/images` directory for uploaded images (greyblake)

# v0.0.3 2014-03-08

* [feature] Make migrations be aware of Foreigner: use foreign keys if possible (greyblake)
* [fixed] Fixed admin login/logout routes (greyblake)


# v0.0.2 2014-03-08

* [changed] Routes are moved to Blogo::Routes and must be mounted with `Blogo::Routes.mount_to` method (greyblake)
* [feature] All Blogo routes start with `blogo_` and are available within rails application (greyblake)


# v0.0.1 2014-03-03

First public release.
