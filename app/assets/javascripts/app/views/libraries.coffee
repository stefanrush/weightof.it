class WOI.Views.Libraries extends Backbone.View
  el: 'section.libraries'

  initialize: (options) ->
    @$list      = @$el.find 'ol.list'
    @$noneFound = @$el.find 'p.none-found'
    @pager      = new WOI.Views.Pager
      el:          @$el.find 'ol.pager'
      parentView:  @
      initialPage: options.initialPage
      pages:       options.collection.pages

    @render options.initialPage
    if @collection.length is 0 then @$noneFound.show() else @$noneFound.hide()

  render: (page = 1) ->
    @$list.empty()
    @collection.page(page).each (library) =>
      @$list.append new WOI.Views.Library({ model: library }).render().el
    @
