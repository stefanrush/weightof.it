class WOI.Views.Pusher extends Backbone.View
  el: 'html'

  initialize: ->
    @open     = false
    @$push    = @$el.find 'section.menu-bar a.push'
    @$close   = @$el.find 'section.pusher a.close'
    @$buttons = $(@$push.concat(@$close))
    @$mask    = @$el.find 'div.mask'

    @$buttons.on 'click', (e) =>
      e.preventDefault()
      @togglePushMenu()

    @$mask.on 'click touchstart', => @close()

    @listenTo Backbone, 'category:change', @close

  togglePushMenu: -> if @open then @close() else @push()

  push: ->
    @$el.addClass('pusher-open')
    @open = true

  close: ->
    @$el.removeClass('pusher-open')
    @open = false
