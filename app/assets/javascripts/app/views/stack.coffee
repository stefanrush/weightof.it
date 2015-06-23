class WOI.Views.Stack extends Backbone.View
  el: 'section.stack'

  events:
    'click div.basic-info' : 'toggleExpanded'
    'click span.clear a'   : 'clear'

  initialize: (options) ->
    @$basic   = @$el.find 'div.basic-info'
    @$weight  = @$el.find 'div.basic-info span.weight'
    @$total   = @$el.find 'div.expanded-info span.total'
    @$items   = @$el.find 'ul.items'

    @gzip     = options.gzip
    @expanded = false

    @renderItems()
    @update()
    @isolateScroll @$items

    @listenTo Backbone, 'library:addToStack', @add
    @listenTo Backbone, 'gzip:change', @updateGzip

  renderItems: ->
    _.each @collection.models, (item) => @renderItem item

  renderItem: (item) ->
    item = item.attributes if item.attributes
    itemView = new WOI.Views.StackItem
      model:      item
      parentView: @
    $item = itemView.render().el
    @$items.append $item

  add: (item) ->
    if @collection.push item
      @flash()
      @renderItem item
      @update(true)

  remove: (itemID) ->
    @collection.remove itemID
    @update()

  clear: (e) ->
    e.preventDefault()
    @collection.clear()
    @$items.empty()
    @update()

  update: (scroll = false) ->
    @updateWeight()
    @updateTotal()
    @updateVisible()
    @updateLong()
    @scrollToBottom() if scroll

  updateWeight: ->
    @$weight.attr 'title', "#{@collection.weight()} B"
    @$weight.html @collection.weightPretty(@gzip)

  updateTotal: ->
    total = @collection.models.length
    form  = if total is 1 then "library" else "libraries"
    @$total.html "#{total} #{form}"

  updateVisible: ->
    if @collection.models.length > 0
      @$el.removeClass 'hidden'
      $('html').addClass 'stack-visible'
    else
      @$el.addClass 'hidden'
      @close() if @expanded
      $('html').removeClass 'stack-visible'

  updateLong: ->
    if @collection.models.length > 3
      @$items.addClass 'long'
    else
      @$items.removeClass 'long'

  updateGzip: (gzip) ->
    @gzip = gzip
    @updateWeight()

  scrollToBottom: ->
    @$items.scrollTop @$items.first('li').height() * @collection.models.length

  flash: ->
    @$basic.css 'color', '#0088ff'
    setTimeout ( => @$basic.css 'color', '#222222' ), 500

  toggleExpanded: (e) ->
    e.preventDefault()
    if @expanded then @close() else @expand()

  expand: ->
    @$el.addClass 'expanded'
    @expanded = true

  close: ->
    @$el.removeClass 'expanded'
    @expanded = false

_.extend WOI.Views.Stack.prototype, WOI.Mixins.ScrollHelpers
