class WOI.Routers.App extends Backbone.Router
  initialize: (options) ->
    @libaries = new WOI.Collections.Libraries()
    @libaries.reset options.libraries

    @categories = new WOI.Collections.Categories()
    @categories.reset options.categories

  routes:
    ''               : 'index'
    'search/:query'  : 'search'
    'category/:name' : 'category'

  index: -> console.log('index')

  search: -> console.log('search')

  cagegory: -> console.log('cagegory')
