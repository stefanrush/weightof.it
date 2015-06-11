class WOI.Views.Pusher extends Backbone.View
  el: 'body'

  initialize: ->
    @open        = false
    @$clickables = @$el.find('section.menu-bar a.push,' +
                             'section.pusher a.close,' +
                             'div.mask')

    @$clickables.on 'click', (e) =>
      e.preventDefault()
      @togglePushMenu()

    @listenTo Backbone, 'category:change', @close

  togglePushMenu: -> if @open then @close() else @push()

  push:  ->
    @$el.addClass('pusher-open')
    @open = true

  close: ->
    @$el.removeClass('pusher-open')
    @open = false
