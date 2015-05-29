class WOI.Views.Sorter extends Backbone.View
  el: 'div.sorter'

  update: (params) -> @updateLinks params, 'sort', 'weight'

_.extend WOI.Views.Sorter.prototype, WOI.Mixins.URLHelpers
_.extend WOI.Views.Sorter.prototype, WOI.Mixins.UpdatableLinks
