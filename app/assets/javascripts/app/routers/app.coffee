class WOI.Routers.App extends Backbone.Router
  initialize: (options) ->
    @initializeLinks()

    @categories = new WOI.Collections.Categories options.categories
    @libraries  = new WOI.Collections.Libraries  options.libraries
    
    new WOI.Views.Searcher()
    new WOI.Views.Sorter()
    new WOI.Views.Categories()

    @listenTo Backbone, 'search:change pager:change', @updateParam

  initializeLinks: ->
    links = 'a:not([data-remote]):not([data-behavior])'
    $(document.body).on 'click', links, (e) =>
      e.preventDefault()
      @.navigate $(e.currentTarget).attr('href'), { trigger: true }

  routes:
    '(category/:slug)' : 'index'

  index: (slug, params) ->
    params or= {}
    params   = _.merge params, { category: slug } if slug
    @params  = params
    
    Backbone.trigger 'page:change', @params

    @category        = @categories.findWhere { slug: slug }
    @librariesSubset = @libraries.filter(@category)
                                 .search(@params)
                                 .sort(@params)

    @librariesView.pager.undelegateEvents() if @librariesView
    @librariesView = new WOI.Views.Libraries
      collection:  @librariesSubset
      initialPage: parseInt @params.page or 1, 10

    @updateTitle()

  updateTitle: ->
    title = "weightof.it"
    title += " - #{@category.get('name')}" if @category
    title += " - Compare JavaScript libraries by weight (file size)"
    document.title = title

  updateParam: (key, value, trigger = true) ->
    newURL = @buildURL @params, key, value, true
    @.navigate newURL, { trigger: trigger }

_.extend WOI.Routers.App.prototype, WOI.Mixins.URLHelpers
