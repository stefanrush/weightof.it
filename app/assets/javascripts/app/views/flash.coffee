class WOI.Views.Flash extends Backbone.View
  el: 'div.flash'

  events:
    'click a.close' : 'close'

  close: (e) ->
    e.preventDefault()
    @$el.remove()
