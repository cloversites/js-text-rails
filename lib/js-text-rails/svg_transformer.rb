require_relative 'text_transformer'

module JsTextRails
  class SvgTransformer < TextTransformer
    def self.default_namespace
      'this.SVG'
    end

    def sanitize_js_string(text)
      text = strip_xml_declaration(text)
      text = escape_js_string(text)
      text
    end

    # Strips <?xml ...?> declarations so that external SVG and XML documents can
    # be added to a document without worry.
    def strip_xml_declaration(text)
      text.gsub(/^\s*<\?xml.*?\?>\s*/im, '')
    end
  end
end
