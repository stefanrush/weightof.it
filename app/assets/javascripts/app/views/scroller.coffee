class WOI.Views.Scroller extends Backbone.View
  el: window

  initialize: ->
    @$content = $('section.content')
    @listenTo Backbone, 'search:scroll', @scrollTo

  scrollTo: (to) ->
    top = if to then @["$#{to}"].offset().top else 0
    @$el.scrollTop top
