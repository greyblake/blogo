class PostPreview
  # @param buttonId [String] id of preview button
  # @param formId [String]
  # @param modalId [String] id of modal with iframe
  # @param postUrl [String] URL to send post request for preview
  constructor: (@buttonId, @formId, @postUrl, @modalId) ->
    @button = $("##{@buttonId}")
    @form   = $("##{@formId}")
    @modal  = $("##{@modalId}")
    @iframe = @modal.find('iframe')

  # Add onclick handler to the button
  init: ->
    url      = @postUrl
    callback = @previewPost

    @button.on 'click', (event) =>
      @updateCKeditor()
      event.preventDefault()
      $.ajax(
        type: "POST",
        url:  url,
        data: @form.serialize(),
        success: (data)=>
          @previewPost(data)
      )

  # Display response data(HTML) in the iframe. And open the modal.
  previewPost: (data) ->
    @iframe.contents().find('html').html(data)
    document.location.hash = @modalId

  # Make CKeditor set value so it can be sent.
  updateCKeditor: ->
    if CKEDITOR?
      for name, instance of CKEDITOR.instances
        instance.updateElement();


# Export
window.PostPreview = PostPreview
