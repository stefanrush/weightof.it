class WOI.Models.Library extends Backbone.Model

class WOI.Collections.Libraries extends Backbone.Collection
  model: WOI.Models.Library

  filter: (category) ->
    filtered = this.models

    if category
      filtered = _.filter filtered, (library) ->
        library.get('category_id') is category.get('id')
    
    new WOI.Collections.Libraries(filtered)

  search: (params) ->
    searched = this.models

    if params.search
      query = @stripText params.search
      searched = _.filter searched, (library) =>
        @stripText(library.get('name')).indexOf(query) isnt -1

    new WOI.Collections.Libraries(searched)

  sort: (params) ->
    sorted = this.models

    switch params.sort
      when 'popularity'
        sorted = _.sortBy sorted, (library) -> -library.get('popularity')
      else
        sorted = _.sortBy sorted, (library) -> library.get('weight')

    new WOI.Collections.Libraries(sorted)

_.extend WOI.Collections.Libraries.prototype, WOI.Mixins.Text
