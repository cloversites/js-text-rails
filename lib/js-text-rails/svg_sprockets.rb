require_relative 'text_sprockets'

module JsTextRails
  class SvgSprockets < TextSprockets
    @extension = 'svg'
    @mime_type = 'image/svg+xml'
  end
end
