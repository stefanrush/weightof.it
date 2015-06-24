class WOI.Views.StackItem extends Backbone.View
  tagName: 'li'

  template: WOI.Templates['stack_item']

  events:
    'click span.remove a' : 'remove'

  initialize: (options) ->
    @parentView = options.parentView
    @gzip       = @parentView.gzip
    @listenTo Backbone, 'gzip:change', @updateGzip

  render: ->
    @$el.html @template { item: @model, gzip: @gzip }
    @

  remove: (e) ->
    e.preventDefault()
    @parentView.remove @model.id
    @$el.remove()

  updateGzip: (gzip) ->
    @gzip = gzip
    @updateWeight()

  updateWeight: ->
    model = if @model.attributes then @model.attributes else @model

    attribute    = if @gzip then 'weight_gzipped' else 'weight'
    weight       = model["#{attribute}"]
    weightPretty = model["#{attribute}_pretty"]

    $weight = @$el.find 'span.weight'
    $weight.html weightPretty
    $weight.attr 'title', "#{weight} B"
