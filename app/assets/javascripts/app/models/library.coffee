class WOI.Models.Library extends Backbone.Model

class WOI.Collections.Libraries extends Backbone.Collection
  model: WOI.Models.Library

  initialize: (models, perPage = 100) ->
    @perPage   = perPage
    @pageCount = Math.ceil models.length / @perPage

  filter: (category) ->
    filtered = @models

    if category
      filtered = _.filter filtered, (library) ->
        library.get('category_id') is category.get('id')
    
    new WOI.Collections.Libraries filtered, @perPage

  search: (params) ->
    searched = @models

    if params.search
      query = @stripText params.search
      searched = _.filter searched, (library) =>
        @stripText(library.get('name')).indexOf(query) isnt -1

    new WOI.Collections.Libraries searched, @perPage

  sort: (params) ->
    sorted = @models

    switch params.sort
      when 'popularity'
        sorted = _.sortBy sorted, (library) -> -library.get('popularity')
      when 'name'
        sorted = _.sortBy sorted, (library) -> library.get('name').toLowerCase()
      else
        sorted = _.sortBy sorted, (library) -> library.get('weight')

    new WOI.Collections.Libraries sorted, @perPage

  page: (number) ->
    paged = @models
    paged = paged.slice (number - 1) * @perPage, number * @perPage
    new WOI.Collections.Libraries paged, @perPage

_.extend WOI.Collections.Libraries.prototype, WOI.Mixins.TextHelpers
