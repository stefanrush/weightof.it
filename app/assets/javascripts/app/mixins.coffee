WOI.Mixins =
  Text:
    stripText: (text) -> text.toLowerCase().replace(/[^\w\s\-\.]+/g, '')
  
  URL:
    buildURL: (params, newkey, newValue) ->
      params = _.merge _.clone(params), { "#{newkey}": newValue } if newkey

      url = "/"
      url += "category/#{params.category}" if params.category
      url += "?search=#{params.search}" if params.search
      if params.sort
        url += if params.search then '&' else '?'
        url += "sort=#{params.sort}"
      url
