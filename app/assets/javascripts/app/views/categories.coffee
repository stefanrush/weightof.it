class WOI.Views.Categories extends Backbone.View
  el: 'aside.categories'

  update: (params) -> @updateLinks params, 'category', 'all'

_.extend WOI.Views.Categories.prototype, WOI.Mixins.URLHelpers
_.extend WOI.Views.Categories.prototype, WOI.Mixins.UpdatableLinks
