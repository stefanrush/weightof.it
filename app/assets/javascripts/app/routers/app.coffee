class WOI.Routers.App extends Backbone.Router
  initialize: (options) ->
    @initializeLinks()

    @categories = new WOI.Collections.Categories options.categories
    @libraries  = new WOI.Collections.Libraries  options.libraries,
                                                 options.perPage
    
    @renderLibraries = false
    
    new WOI.Views.Searcher()
    new WOI.Views.Sorter()
    new WOI.Views.Categories()
    new WOI.Views.Pusher()

    @listenTo Backbone, 'search:change pager:change', @updateParam

  routes:
    '(category/:slug)' : 'index'

  index: (slug, params = {}) ->
    params  = _.extend params, { category: slug } if slug
    @params = params
    Backbone.trigger 'page:change', @params

    @category        = @categories.findWhere { slug: slug }
    @librariesSubset = @libraries.filter(@category)
                                 .search(@params)
                                 .sort(@params)

    @librariesView.pager.undelegateEvents() if @librariesView
    @librariesView = new WOI.Views.Libraries
      collection:  @librariesSubset
      params:      @params
      initialPage: parseInt @params.page or 1, 10
      render:      @renderLibraries
    @renderLibraries = true unless @renderLibraries
    
    @updateTitle()

  initializeLinks: ->
    links = 'a:not([data-remote]):not([data-behavior])'
    $(document.body).on 'click', links, (e) =>
      e.preventDefault()
      @.navigate $(e.currentTarget).attr('href'), { trigger: true }

  updateTitle: ->
    title  = "weightof.it"
    title += " - #{@category.get('name')}" if @category
    title += " - Compare JavaScript libraries by weight (file size)"
    document.title = title

  updateParam: (key, value, trigger = true, includePage = false) ->
    newURL = @buildURL @params, key, value, includePage
    @.navigate newURL, { trigger: trigger }

_.extend WOI.Routers.App.prototype, WOI.Mixins.URLHelpers
