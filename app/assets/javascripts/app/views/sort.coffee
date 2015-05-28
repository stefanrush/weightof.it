class WOI.Views.Sort extends Backbone.View
  el: 'div.sort'

  initialize: ->
    @$links  = @$el.find 'a'
    @$active = @$links.find '.active'
    @listenTo Backbone, 'page:change', @update

  update: (params) ->
    @updateActive params
    @updateLinks params

  updateActive: (params) ->
    @$links.removeClass 'active'
    sort = params.sort or 'weight'
    @$active = @$links.filter("[data-sort=\"#{sort}\"]")
    @$active.addClass 'active'

  updateLinks: (params) ->
    @$links.each (i, el) =>
      sortBy = $(el).data 'sort'
      $(el).attr 'href', @buildURL(params, sortBy)
  
  buildURL: (params, sortBy) ->
    url = "/"
    url += "category/#{params.category}" if params.category
    url += "?search=#{params.search}" if params.search
    url += if params.search then '&' else '?'
    url += "sort=#{sortBy}"
    url