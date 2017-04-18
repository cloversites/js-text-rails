module JsTextRails
  class TextTransformer
    def self.default_namespace
      'this.TEXT'
    end

    def initialize(options = {})
      @namespace = options[:namespace] || self.class.default_namespace
    end

    # Take `data` and store it at a `key` in a JS namespace.
    def transform(key, data)
      <<-TEXT
(function() { #{@namespace} || (#{@namespace} = {}); #{@namespace}[#{key}] = '#{sanitize_js_string(data)}';
}).call(this);
      TEXT
    end

    # Can be overridden by subclasses.
    def sanitize_js_string(text)
      escape_js_string(text)
    end

    # Make text content safe and correct when evaluated in JS.
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
