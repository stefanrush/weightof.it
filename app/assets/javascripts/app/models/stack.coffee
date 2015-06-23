class WOI.Collections.Stack extends Backbone.Collection
  initialize: ->
    @storage = Modernizr.localstorage
    store    = if @storage then localStorage.getItem 'woi-stack' else null
    @models  = if store then JSON.parse(store)['stack'] else []

  push: (item) ->
    if _.findWhere @models, { id: item.get 'id' }
      false
    else
      @models.push item.attributes
      @persist()
      true

  remove: (itemID) ->
    @models = _.without @models, _.findWhere(@models, { id: itemID })
    @persist()

  clear: ->
    @models = []
    @persist()

  persist: -> 
    if @storage
      localStorage.setItem 'woi-stack', JSON.stringify({ stack: @models })

  weight: (gzip) ->
    attribute = if gzip then '_gzipped' else ''
    weight = 0
    _.each @models, (item) -> weight += item["weight#{attribute}"]
    weight

  weightPretty: (gzip) ->
    weight = @weight gzip
    if weight < 1000
      unit      = "B"
      precision = 0
    else if weight < 1e6
      weight   /= 1000
      unit      = "KB"
      precision = 1
    else if weight < 1e9
      weight   /= 1e6
      unit      = "MB"
      precision = 2
    else
      weight   /= 1e9
      unit      = "GB"
      precision = 3
    "#{weight.toFixed(precision)} #{unit}"
