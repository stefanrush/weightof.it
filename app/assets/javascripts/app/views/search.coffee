class WOI.Views.Search extends Backbone.View
  el: 'div.search'

  events:
    'keyup input'    : 'search'
    'click a.submit' : 'search'
    'click a.clear'  : 'clear'

  initialize: (options) ->
    @query   = ''
    @$input  = @$el.find '#search'
    @$submit = @$el.find 'a.submit'
    @$clear  = @$el.find 'a.clear'
    @listenTo Backbone, 'page:change', @update

  search: (e) ->
    e.preventDefault()
    @query = @stripText @$input.val()
    Backbone.trigger 'search:change', @query

  clear: (e) ->
    e.preventDefault()
    @$input.val('')
    @$submit.trigger('click')

  update: (params) ->
    if not params.search and @query or params.search and not @query
      @query = @stripText(params.search or '')
      @$input.val(@query)
    @toggleClearable()

  toggleClearable: ->
    if @query then @$clear.show() else @$clear.hide()

_.extend WOI.Views.Search.prototype, WOI.Mixins.Text
