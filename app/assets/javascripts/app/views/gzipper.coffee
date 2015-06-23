class WOI.Views.Gzipper extends Backbone.View
  el: 'div.gzipper'

  events:
    'change #gzip' : 'toggleGzip'

  initialize: ->
    @$input = @$el.find '#gzip'
    @gzipped = true

  toggleGzip: ->
    @gzipped = @$input.is ':checked'
    Backbone.trigger 'gzip:change', @gzipped
