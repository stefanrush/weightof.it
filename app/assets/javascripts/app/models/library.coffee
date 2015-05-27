class WOI.Models.Library extends Backbone.Model

class WOI.Collections.Libraries extends Backbone.Collection
  model: WOI.Models.Library

  filter: (category, params) =>
    filtered = this.models

    if category
      filtered = _.filter filtered, (library) ->
        library.get('category_id') is category.get('id')
    
    new WOI.Collections.Libraries(filtered)
