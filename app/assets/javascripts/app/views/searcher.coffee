class WOI.Views.Searcher extends Backbone.View
  el: 'form.searcher'

  events:
    'keyup input'    : 'search'
    'click a.submit' : 'search'
    'click a.clear'  : 'clear'

  initialize: (options) ->
    @$el.on 'submit', (e) -> e.preventDefault()
    @query   = ''
    @$input  = @$el.find '#search'
    @$submit = @$el.find 'button.submit'
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

  updateClearable: ->
    if @query then @$clear.removeClass 'hidden' else @$clear.addClass 'hidden'

_.extend WOI.Views.Searcher.prototype, WOI.Mixins.TextHelpers
