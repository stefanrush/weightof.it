class WOI.Views.Libraries extends Backbone.View
  el: 'section.libraries'

  initialize: ->
    @$list = @$el.find('ol')
    @render()

  render: ->
    if @collection.length is 0
      @$list.html('No libraries found.') 
    else
      @$list.empty()
      @collection.each (library) =>
        @$list.append new WOI.Views.Library({ model: library }).render().el
    @
