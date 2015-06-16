class WOI.Views.Searcher extends Backbone.View
  el: 'form.searcher'

  events:
    'keyup input#search'  : 'search'
    'submit'              : 'submit'
    'click button.submit' : 'submit'
    'click a.clear'       : 'clear'
    'focus input#search'  : 'focus'
    'blur input#search'   : 'blur'

  initialize: (options) ->
    @query   = ''
    @change  = null
    @$input  = @$el.find '#search'
    @$submit = @$el.find 'button.submit'
    @$clear  = @$el.find 'a.clear'
    @listenTo Backbone, 'page:change', @update

  search: (timer) ->
    @query = @stripText @$input.val()
    
    timer = 500 unless typeof timer is 'number'
    clearTimeout @change
    @change = setTimeout ( =>
      Backbone.trigger 'search:change', 'search', @query
    ), timer

  submit: (e) ->
    e.preventDefault()
    @search 0
    if @query and @focused()
      Backbone.trigger 'search:scroll', 'content'
    else
      @$input.focus()

  clear: (e) ->
    e.preventDefault()
    @$input.val ''
    @search 0

  focused: -> @$el.hasClass 'focused'
  focus:   -> @$el.addClass 'focused'
  blur:    -> setTimeout ( => @$el.removeClass 'focused' ), 250

  update: (params) ->
    @updateInput params.search
    @updateClearable()

  updateInput: (newQuery) ->
    if (not newQuery and @query) or (newQuery and not @query)
      @query = @stripText(newQuery or '')
      @$input.val(@query)

  updateClearable: ->
    if @query then @$clear.removeClass 'hidden' else @$clear.addClass 'hidden'

_.extend WOI.Views.Searcher.prototype, WOI.Mixins.TextHelpers
