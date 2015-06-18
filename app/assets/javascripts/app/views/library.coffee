class WOI.Views.Library extends Backbone.View
  tagName: 'li'

  template: WOI.Templates['library']

  events:
    'click span.add-to-stack a' : 'addToStack'

  render: ->
    @$el.html @template { library: @model.attributes }
    @

  addToStack: (e) ->
    e.preventDefault()
    Backbone.trigger 'library:addToStack', @model
