class WOI.Views.Sort extends Backbone.View
  el: 'div.sort'

  update: (params) -> @updateLinks params, 'sort', 'weight'

_.extend WOI.Views.Sort.prototype, WOI.Mixins.URLHelpers
_.extend WOI.Views.Sort.prototype, WOI.Mixins.UpdatableLinks
