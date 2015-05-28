class WOI.Views.Libraries extends Backbone.View
  el: 'section.libraries'

  initialize: ->
    @$list = @$el.find 'ol'
    @$noneFound = @$el.find 'p.none-found'
    @render()

  render: ->
    @$list.empty()
    if @collection.length is 0
      @$noneFound.show()
    else
      @$noneFound.hide()
      @collection.each (library) =>
        @$list.append new WOI.Views.Library({ model: library }).render().el
    @
