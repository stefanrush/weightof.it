WOI.Mixins =
  TextHelpers:
    stripText: (text) -> text.toLowerCase().replace(/[^\w\s\-\.]+/g, '')
  
  URLHelpers:
    buildURL: (params = {}, newkey, newValue, includePage = false) ->
      params = _.extend _.clone(params), { "#{newkey}": newValue } if newkey

      url = "/"
      if params.category and params.category isnt 'all'
        url += "category/#{params.category}"
      if params.search
        url += "?search=#{params.search}"
      if params.sort and params.sort isnt 'weight'
        url += if params.search then '&' else '?'
        url += "sort=#{params.sort}"
      if includePage and params.page and params.page > 1
        url += if params.search or params.sort then '&' else '?'
        url += "page=#{params.page}"
      url

  ScrollHelpers:
    isolateScroll: ($el) ->
      $el.on 'mousewheel', (e) ->
        height       = $(@).height()
        scrollHeight = $(@).get(0).scrollHeight
        delta        = e.deltaY
        
        if (@scrollTop is (scrollHeight - height) and delta > 0) or
           (@scrollTop is 0 and delta < 0)
          e.preventDefault()

  UpdatableLinks:
    initialize: ->
      @$links  = @$el.find 'a'
      @$active = @$links.find '.active'
      @listenTo Backbone, 'page:change', @update
      
    updateLinks: (params, key, defaultValue) ->
      @updateActiveLink key, params[key] or defaultValue
      @updateLinkHREFs params, key

    updateActiveLink: (key, value) ->
      @$links.removeClass 'active'
      @$active = @$links.filter "[data-#{key}=\"#{value}\"]"
      @$active.addClass 'active'

    updateLinkHREFs: (params, key) ->
      @$links.each (i, el) =>
        value = $(el).data key
        $(el).attr 'href', @buildURL(params, key, value)

  UpdatableWeight:
    updateGzip: (gzip) ->
      @gzip = gzip
      @updateWeight()

    updateWeight: ->
      model = if @model.attributes then @model.attributes else @model

      attribute    = if @gzip then '_gzipped' else ''
      weight       = model["weight#{attribute}"]
      weightPretty = model["weight#{attribute}_pretty"]

      $weight = @$el.find 'span.weight'
      $weight.html weightPretty
      $weight.attr 'title', "#{weight} B"
