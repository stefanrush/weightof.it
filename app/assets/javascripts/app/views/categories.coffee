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
    @$active = @$links.filter "[data-category=\"#{category}\"]"
    @$active.addClass 'active'

  updateLinks: (params) ->
    @$links.each (i, el) =>
      category = $(el).data 'category'
      $(el).attr 'href', @buildURL(params, 'category', category)

_.extend WOI.Views.Categories.prototype, WOI.Mixins.URL
