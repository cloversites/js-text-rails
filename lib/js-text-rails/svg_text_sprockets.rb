require_relative 'text_sprockets'

module JsTextRails
  class SvgTextSprockets < TextSprockets
    @extension = 'svg'
    @mime_type = 'image/svg+xml'
  end
end
