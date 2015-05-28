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
      $(el).attr 'href', @buildURL(params, 'sort', sortBy)

_.extend WOI.Views.Sort.prototype, WOI.Mixins.URL
