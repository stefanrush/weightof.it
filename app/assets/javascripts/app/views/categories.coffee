class WOI.Views.Categories extends Backbone.View
  el: 'aside.categories'

  events:
    'click a' : 'categoryChange'

  update: (params) -> @updateLinks params, 'category', 'all'

  categoryChange: -> Backbone.trigger 'category:change'

_.extend WOI.Views.Categories.prototype, WOI.Mixins.URLHelpers
_.extend WOI.Views.Categories.prototype, WOI.Mixins.UpdatableLinks
