class WOI.Views.Version extends Backbone.View
  tagName: 'li'

  template: WOI.Templates['version']

  initialize: (options) -> @index = options.index

  render: ->
    @$el.html @template { index: @index }
    @$el.data 'index', @index
    @
