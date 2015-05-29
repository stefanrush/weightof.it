class WOI.Views.Libraries extends Backbone.View
  el: 'section.libraries'

  initialize: (options) ->
    @$list      = @$el.find 'ol.list'
    @$noneFound = @$el.find 'p.none-found'
    @$total     = @$el.find 'p.total'

    @updateInfo()
    @render options.initialPage

    @pager = new WOI.Views.Pager
      el:          @$el.find 'ol.pager'
      parentView:  @
      initialPage: options.initialPage
      pages:       options.collection.pages

  render: (page = 1) ->
    @$list.empty()
    pageLibraries = @collection.page(page)
    pageLibraries.each (library) =>
      @$list.append new WOI.Views.Library({ model: library }).render().el
    @updateInfo pageLibraries.length, false
    @

  updateInfo: (total = @collection.length, updateTotal = true) ->
    if total is 0
      @$noneFound.show()
      @$total.hide()
    else
      @$noneFound.hide()
      @$total.html "#{total} found" if updateTotal
      @$total.show()
