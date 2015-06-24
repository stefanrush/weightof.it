class WOI.Routers.App extends Backbone.Router
  initialize: (options) ->
    @categories = new WOI.Collections.Categories options.categories
    @libraries  = new WOI.Collections.Libraries  options.libraries,
                                                 options.perPage
    @stack      = new WOI.Collections.Stack()
    @gzip       = true

    @initializeLinks()
    @initializeComponents()
    @listenTo Backbone, 'search:change pager:change', @updateParam
    @listenTo Backbone, 'gzip:change', @updateGzip

  routes:
    '(category/:slug)' : 'index'

  index: (slug, params = {}) ->
    params  = _.extend params, { category: slug } if slug
    params  = _.extend params, { gzip: @gzip }
    @params = params
    Backbone.trigger 'page:change', @params

    @category        = @categories.findWhere { slug: slug }
    @librariesSubset = @libraries.subset @category, @params

    @librariesView.pager.undelegateEvents() if @librariesView
    @librariesView = new WOI.Views.Libraries
      collection:  @librariesSubset
      params:      @params
      initialPage: parseInt @params.page or 1, 10
      gzip:        @gzip
    
    @updateTitle()

  initializeLinks: ->
    links = 'a:not([data-remote]):not([data-behavior])'
    $(document.body).on 'click', links, (e) =>
      e.preventDefault()
      @.navigate $(e.currentTarget).attr('href'), { trigger: true }

  initializeComponents: ->
    new WOI.Views.Searcher()
    new WOI.Views.Gzipper()
    new WOI.Views.Sorter()
    new WOI.Views.Categories()
    new WOI.Views.Pusher()
    new WOI.Views.Stack { collection: @stack, gzip: @gzip }
    new WOI.Views.Flash()

  updateTitle: ->
    title  = ""
    title += "#{@category.get('name')} - " if @category
    title += "Compare JavaScript libraries by weight (file size) - weightof.it"
    document.title = title

  updateParam: (key, value, trigger = true, includePage = false) ->
    newURL = @buildURL @params, key, value, includePage
    @.navigate newURL, { trigger: trigger }

  updateGzip: (gzip) -> @gzip = gzip

_.extend WOI.Routers.App.prototype, WOI.Mixins.URLHelpers
