module JsTextRails
  class ObjectTransformer
    def self.default_namespace
      'this.TEXT'
    end

    def initialize(options = {})
      @namespace = options[:namespace] || self.class.default_namespace
    end

    # Take `data` and store it at a `key` in a JS namespace.
    def transform(key, data)
      <<-TEXT
(function() { #{@namespace} || (#{@namespace} = {}); #{@namespace}[#{key}] = #{data};
}).call(this);
      TEXT
    end
  end
end
