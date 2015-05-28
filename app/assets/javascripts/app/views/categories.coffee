class WOI.Views.Categories extends Backbone.View
  el: 'aside.categories'

  initialize: ->
    @$links  = @$el.find 'a'
    @$active = @$links.find '.active'
    @listenTo Backbone, 'page:change', @update

  update: (params) ->
    @updateActive params
    @updateLinks params

  updateActive: (params) ->
    @$links.removeClass 'active'
    category = params.category or 'all'
    @$active = @$links.filter("[data-category=\"#{category}\"]")
    @$active.addClass 'active'

  updateLinks: (params) ->
    @$links.each (i, el) =>
      category = $(el).data 'category'
      category = null if category is 'all'
      $(el).attr 'href', @buildURL(params, category)
  
  buildURL: (params, category) ->
    url = "/"
    url += "category/#{category}" if category
    url += "?search=#{params.search}" if params.search
    if params.sort
      url += if params.search then '&' else '?'
      url += "sort=#{params.sort}" 
    url
