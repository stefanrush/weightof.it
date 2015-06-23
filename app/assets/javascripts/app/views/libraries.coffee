class WOI.Views.Libraries extends Backbone.View
  el: 'section.libraries'

  initialize: (options) ->
    @$list       = @$el.find 'ol.list'
    @$totalFound = @$el.find 'p.total-found'
    @$noneFound  = @$el.find 'p.none-found'

    @updateInfo()

    @gzip = options.gzip
    @listenTo Backbone, 'gzip:change', @updateGzip

    @render options.initialPage

    @pager = new WOI.Views.Pager
      el:          @$el.find 'ol.pager'
      parentView:  @
      params:      options.params
      initialPage: options.initialPage
      pageCount:   options.collection.pageCount

  render: (page = 1) ->
    @$list.empty()
    pageLibraries = @collection.page page
    pageLibraries.each (library) =>
      libraryView = new WOI.Views.Library { model: library, gzip: @gzip }
      @$list.append libraryView.render().el
    @updateInfo pageLibraries.length, false
    @

  updateInfo: (total = @collection.length, updateTotal = true) ->
    if total is 0
      @$noneFound.removeClass 'hidden'
      @$totalFound.addClass 'hidden'
    else
      @$noneFound.addClass 'hidden'
      @$totalFound.html "#{total} found" if updateTotal
      @$totalFound.removeClass 'hidden'

  updateGzip: (gzip) -> @gzip = gzip
