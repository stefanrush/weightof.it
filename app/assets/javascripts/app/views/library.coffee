class WOI.Views.Library extends Backbone.View
  tagName: 'li'

  template: WOI.Templates['library']

  render: ->
    @$el.html @template { library: @model.attributes }
    @
