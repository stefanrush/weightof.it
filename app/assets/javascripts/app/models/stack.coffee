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

  weight: ->
    weight = 0
    _.each @models, (item) -> weight += item.weight
    weight

  weightPretty: ->
    weight = @weight()
    if weight < 1000
      unit = "B"
    else if weight < 1e6
      weight /= 1000
      unit = "KB"
    else if weight < 1e9
      weight /= 1e6
      unit = "MB"
    else
      weight /= 1e9
      unit = "GB"
    "#{weight.toFixed(1)} #{unit}"
