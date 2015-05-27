class WOI.Routers.App extends Backbone.Router
  initialize: (options) ->
    @initializeLinks()

    @categories = new WOI.Collections.Categories()
    @categories.reset options.categories

    @libraries = new WOI.Collections.Libraries()
    @libraries.reset options.libraries

  initializeLinks: ->
    $(document.body).on 'click', 'a', (e) =>
      e.preventDefault()
      @.navigate $(e.currentTarget).attr('href'), { trigger: true }

  routes:
    '(category/:slug)' : 'index'

  index: (slug, params) ->
    @category = @categories.findWhere { slug: slug }
    @filteredLibraries = @libraries.filter(@category, params)
    @librariesView = new WOI.Views.Libraries({ collection: @filteredLibraries })
