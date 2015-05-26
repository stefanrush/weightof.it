class WOI.Models.Library extends Backbone.Model
  paramRoot: 'library'

class WOI.Collections.Libraries extends Backbone.Collection
  model: WOI.Models.Library
  url: '/libary'
