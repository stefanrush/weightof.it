class WOI.Views.Library extends Backbone.View
  tagName: 'li'

  template: WOI.Templates['library']

  events:
    'click span.add-to-stack a' : 'addToStack'
    'click a'                   : 'stopClose'
    'click'                     : 'toggleExpanded'

  initialize: (options) ->
    @gzip = options.gzip
    @listenTo Backbone, 'gzip:change', @updateGzip

  render: ->
    @$el.html @template { library: @model.attributes, gzip: @gzip }
    @

  addToStack: (e) ->
    e.preventDefault()
    Backbone.trigger 'library:addToStack', @model

  stopClose: ->
    @$el.addClass 'stop-close'
    setTimeout ( => @$el.removeClass 'stop-close' ), 100

  toggleExpanded: ->
    @$el.toggleClass 'expanded' unless @$el.hasClass 'stop-close'

_.extend WOI.Views.Library.prototype, WOI.Mixins.UpdatableWeight
