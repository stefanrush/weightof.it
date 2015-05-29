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
    e.preventDefault() if e
    @query = @stripText @$input.val()
    Backbone.trigger 'search:change', 'search', @query

  clear: (e) ->
    e.preventDefault()
    @$input.val ''
    @search()

  update: (params) ->
    @updateInput params.search
    @updateClearable()

  updateInput: (newQuery) ->
    if not newQuery and @query or newQuery and not @query
      @query = @stripText(newQuery or '')
      @$input.val(@query)

  updateClearable: -> if @query then @$clear.show() else @$clear.hide()

_.extend WOI.Views.Search.prototype, WOI.Mixins.Text
