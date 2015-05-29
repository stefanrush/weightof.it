WOI.Mixins =
  Text:
    stripText: (text) -> text.toLowerCase().replace(/[^\w\s\-\.]+/g, '')
  
  URL:
    buildURL: (params, newkey, newValue, includePage = false) ->
      params = _.merge _.clone(params), { "#{newkey}": newValue } if newkey

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

  Updatable:
    updateAll: (params, key, default) ->
      @updateActive key, params[key] or default
      @updateLinks params, key

    updateActive: (key, value) ->
      @$links.removeClass 'active'
      @$active = @$links.filter "[data-#{key}=\"#{value}\"]"
      @$active.addClass 'active'

    updateLinks: (params, key) ->
      @$links.each (i, el) =>
        value = $(el).data key
        $(el).attr 'href', @buildURL(params, key, value)
