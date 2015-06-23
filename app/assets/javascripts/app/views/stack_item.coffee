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

_.extend WOI.Views.StackItem.prototype, WOI.Mixins.UpdatableWeight
