class WOI.Models.Library extends Backbone.Model

class WOI.Collections.Libraries extends Backbone.Collection
  model: WOI.Models.Library

  initialize: (models, perPage, sortBy='weight') ->
    @perPage   = perPage
    @pageCount = Math.ceil models.length / @perPage
    @sortBy    = sortBy

  subset: (category, params) ->
    @filter(category).search(params.search).sort(params.sort, params.gzip)

  filter: (category) ->
    filtered = @models

    if category
      categoryID = category.get('id')
      filtered = _.filter filtered, (library) ->
        library.get('category_id') is categoryID
    
    new WOI.Collections.Libraries filtered, @perPage, @sortBy

  search: (query) ->
    searched = @models

    if query
      query = @stripText query
      searched = _.filter searched, (library) =>
        @stripText(library.get('name')).indexOf(query) isnt -1

    new WOI.Collections.Libraries searched, @perPage, @sortBy

  sort: (sortBy, gzip=true) ->
    @sortBy = sortBy
    sorted  = @models

    switch @sortBy
      when 'popularity'
        sorted = _.sortBy sorted, (library) -> -library.get('popularity')
      when 'name'
        sorted = _.sortBy sorted, (library) -> library.get('name').toLowerCase()
      else
        attribute = if gzip then 'weight_gzipped' else 'weight'
        sorted = _.sortBy sorted, (library) -> library.get(attribute)

    new WOI.Collections.Libraries sorted, @perPage, @sortBy

  page: (number) ->
    paged = @models
    paged = paged.slice (number - 1) * @perPage, number * @perPage
    new WOI.Collections.Libraries paged, @perPage, @sortBy

_.extend WOI.Collections.Libraries.prototype, WOI.Mixins.TextHelpers
