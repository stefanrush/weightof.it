class WOI.Views.StackItem extends Backbone.View
  tagName: 'li'

  template: WOI.Templates['stack_item']

  events:
    'click span.remove a' : 'remove'

  initialize: (options) ->
    @parentView = options.parentView

  render: ->
    @$el.html @template { item: @model }
    @

  remove: (e) ->
    e.preventDefault()
    @parentView.remove @model.id
    @$el.remove()
