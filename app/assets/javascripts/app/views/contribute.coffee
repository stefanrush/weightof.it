class WOI.Views.Contribute extends Backbone.View
  el: '#new_library'

  events:
    'click a.add-version'    : 'addVersion'
    'click a.remove-version' : 'removeVersion'
    'submit'                 : 'submit'

  initialize: ->
    @validators = ['Required', 'URL', 'Number', 'JS']
    @matchers   =
      URL:    /^https?:\/\/.+\..+$/
      number: /^(\d+\.)*\d+$/
      JS:     /^https?:\/\/.+\..+\.js$/

    @$versionsList = @$el.find 'ul.versions'
    @versionsCount = 1
    @versionsLimit = 10

  inputs: -> @$el.find 'input[type="text"], select'

  submit: (e) -> e.preventDefault() unless @validateForm()

  validateForm: ->
    valid = true
    @inputs().each (n, input) =>
      $input = $(input)
      @removeError $input
      for validator in @validators
        if $input.data validator.toLowerCase()
          message = @["validate#{validator}"]($input.val())
          if typeof message is 'string'
            @addError $input, message
            valid = false
            break
    valid = false unless @validateRecaptcha()
    valid

  validateRequired: (value) ->
    value.length > 0 or "Required"

  validateURL: (value) ->
    value.length is 0 or value.match(@matchers.URL) or "Invalid URL"

  validateNumber: (value) ->
    value.length is 0 or value.match(@matchers.number) or "Invalid number"

  validateJS: (value) ->
    value.length is 0 or value.match(@matchers.JS) or "Invalid JS file"

  validateRecaptcha: ->
    $recaptcha = @$el.find 'div.g-recaptcha'
    if window.grecaptcha.getResponse().length > 0
      @removeError $recaptcha
      true
    else
      @addError $recaptcha
      false

  addError: ($input, message) ->
    $input.addClass 'error'
    if message
      $errorMessage = $('<div>').addClass('error-message').html(message)
      $input.after $errorMessage

  removeError: ($input) ->
    $input.removeClass 'error'
    $input.siblings('.error-message').remove()

  versionItems: -> @$versionsList.find 'li'

  addVersion: (e) ->
    e.preventDefault()
    if @versionsCount < @versionsLimit
      version = new WOI.Views.Version({ index: @versionsCount }).render().el
      @$versionsList.append version
      @versionsCount++

  removeVersion: (e) ->
    e.preventDefault()
    $version = $(e.currentTarget).parents 'li'
    $version.remove()
    @versionsCount--
    @reindexVersions()

  reindexVersions: ->
    @versionItems().each (n, item) =>
      $item = $(item)
      index = parseInt($item.data('index'), 10)
      @replaceAttributes($item, n) if index isnt n

  replaceAttributes: ($item, n) ->
    $item.data 'index', n
    $item.find('input, label').each ->
      $el = $(@)
      for attribute in ['id', 'name', 'for']
        oldValue = $el.attr attribute
        if oldValue
          newValue = oldValue.replace /\d+/, n
          $el.attr attribute, newValue
