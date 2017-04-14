module JsTextRails
  # Register transformer in Sprockets.
  class TextSprockets
    def self.register_transformer(transformer)
      @transformer = transformer
    end

    # Sprockets 3 and 4 API
    def self.call(input)
      name = input[:name].inspect
      data = input[:data].gsub(/$(.)/m, "\\1  ").strip
      run(name, data)
    end

    # Transform `data` into a JS object value at `key`.
    def self.run(key, data)
      @transformer.transform(key, data)
    end

    def self.install(env)
      # TODO: Is the original extension for the mime type also needed as an
      # extension?  (Does the array override the old one, or get merged?)
      env.register_mime_type(@mime_type, extensions: [".#{@extension}"])
      env.register_transformer(@mime_type, 'application/javascript', self)
    end

    def self.uninstall(env)
      # TODO: Is the original extension for the mime type also needed as an
      # extension?  (What would be the consequences of unregistering?)
      env.unregister_mime_type(@mime_type, extensions: [".#{@extension}"])
      env.unregister_transformer(@mime_type, 'application/javascript', self)
    end
  end
end
