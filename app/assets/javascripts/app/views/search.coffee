class WOI.Views.Search extends Backbone.View
  el: 'div.search'

  events:
    'keyup input'    : 'search'
    'click a.submit' : 'search'
    'click a.clear'  : 'clear'

  initialize: (options) ->
    @app     = options.app
    @query   = ''
    @$input  = @$el.find '#search'
    @$submit = @$el.find 'a.submit'
    @$clear  = @$el.find 'a.clear'
    @listenTo Backbone, 'page:change', @update

  search: (e) ->
    e.preventDefault()
    @query = @strip @$input.val()
    @app.navigate @buildURL(@query, @app.params), { trigger: true }

  clear: (e) ->
    e.preventDefault()
    @$input.val('')
    @$submit.trigger('click')

  update: (params) ->
    if not params.search and @query or params.search and not @query
      @query = @strip(params.search or '')
      @$input.val(@query)
    @toggleClearable()

  toggleClearable: ->
    if @query then @$clear.show() else @$clear.hide()

  buildURL: (query, params) ->
    url = "/"
    url += "category/#{params.category}" if params.category
    url += "?search=#{query}" if query
    if params.sort
      url += if query then '&' else '?'
      url += "sort=#{params.sort}"
    url

_.extend WOI.Views.Search.prototype, WOI.Mixins
