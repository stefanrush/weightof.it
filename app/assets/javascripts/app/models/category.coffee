class WOI.Models.Category extends Backbone.Model
  paramRoot: 'category'

class WOI.Collections.Categories extends Backbone.Collection
  model: WOI.Models.Category
  url: '/category'
