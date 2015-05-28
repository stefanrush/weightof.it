class WOI.Routers.App extends Backbone.Router
  initialize: (options) ->
    @initializeLinks()

    @categories = new WOI.Collections.Categories()
    @categories.reset options.categories

    @libraries = new WOI.Collections.Libraries()
    @libraries.reset options.libraries

    new WOI.Views.Categories()
    new WOI.Views.Sort()
    new WOI.Views.Search()

    @listenTo Backbone, 'search:change', @search

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

    @librariesView = new WOI.Views.Libraries { collection: @librariesSubset }

    @updateTitle()

  search: (query) ->
    searchURL = @buildURL @params, 'search', query
    @.navigate searchURL, { trigger: true }

  updateTitle: ->
    title = "weightof.it"
    if @category
      title += " - #{@category.get('name')}"
    title += " - Compare JavaScript libraries by weight (file size)"
    document.title = title

_.extend WOI.Routers.App.prototype, WOI.Mixins.URL
