# Automatically fills URL for a post from a title.
$.fn.titleToUrl =  (urlSelector) ->
  titleInput = $(this)
  urlInput = $(urlSelector)

  titleInput.on 'input', ->
    url = toUrl(titleInput.val())
    urlInput.val(url)


# Convert title to URL
toUrl = (title) ->
  url = title.toLowerCase()

  url = url.replace("'", '');
  url = url.replace(/[^a-z0-9]/g, ' ')
  url = url.replace(/^\s+|\s+$|/g, '');
  url = url.replace(/\s+/g, '-')
  url
