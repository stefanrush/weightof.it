WOI.Mixins =
  strip: (text) -> text.toLowerCase().replace(/[^\w\s\-\.]+/g, '')
