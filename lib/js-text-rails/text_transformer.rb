module JsTextRails
  class TextTransformer
    # Take text and return a JavaScript code representation of the text.
    def transform(text)
      "'#{escape_js_string(text)}'"
    end

    private

    # TODO: Test this.
    def escape_js_string(text)
      text
        .gsub(/(['\\])/, "\\\\\\1")
        .gsub(/[\f]/, '\f')
        .gsub(/[\b]/, '\b')
        .gsub(/[\n]/, '\n')
        .gsub(/[\t]/, '\t')
        .gsub(/[\r]/, '\r')
        .gsub(/[\u2028]/, '\u2028')
        .gsub(/[\u2029]/, '\u2029')
    end
  end
end
