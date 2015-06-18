class WOI.Views.Pager extends Backbone.View
  events:
    'click li a' : 'loadPage'

  initialize: (options) ->
    @parentView = options.parentView
    @params     = options.params
    @page       = options.initialPage
    @pageCount  = options.pageCount

    @updateVisibility()

    @$first    = @$el.find('li.first').data('page', 1)
    @$previous = @$el.find('li.previous')
    @$current  = @$el.find('li.current')
    @$next     = @$el.find('li.next')
    @$last     = @$el.find('li.last').data('page', @pageCount)

    @updatePages()

  loadPage: (e) ->
    e.preventDefault()
    $page = $(e.currentTarget).parent()
    unless $page.hasClass 'disabled'
      @page = parseInt $page.data('page'), 10
      @parentView.render @page
      @updatePages()
      Backbone.trigger 'pager:change', 'page', @page, false, true

  updatePages: ->
    @updatePageHREFs()
    @updateCurrentPage()
    @updatePageData()
    @updatePageDisabled()

  updatePageHREFs: ->
    @updateLink @$first,    @buildURL(@params)
    @updateLink @$previous, @buildURL(@params, 'page', @previousPage(), true)
    @updateLink @$next,     @buildURL(@params, 'page', @nextPage(),     true)
    @updateLink @$last,     @buildURL(@params, 'page', @pageCount,      true)

  updateLink: ($item, href) -> $item.find('a').attr('href', href)

  updateCurrentPage: ->
    @$current.html(@page).attr('title', "Page #{@page} of #{@pageCount}")

  updatePageData: ->
    @$previous.data 'page', @previousPage()
    @$next.data     'page', @nextPage()

  updatePageDisabled: ->
    if @page <= 1
      @$first.addClass    'disabled'
      @$previous.addClass 'disabled'
    else
      @$first.removeClass    'disabled'
      @$previous.removeClass 'disabled'

    if @page >= @pageCount
      @$next.addClass 'disabled'
      @$last.addClass 'disabled'
    else
      @$next.removeClass 'disabled'
      @$last.removeClass 'disabled'

  previousPage: -> if @page <= 1          then 1          else @page - 1
  nextPage:     -> if @page >= @pageCount then @pageCount else @page + 1

  updateVisibility: ->
    if @pageCount > 1 and @page >= 1 and @page <= @pageCount
      @show()
    else
      @hide()

  show: -> @$el.removeClass 'hidden'
  hide: -> @$el.addClass    'hidden'

_.extend WOI.Views.Pager.prototype, WOI.Mixins.URLHelpers
