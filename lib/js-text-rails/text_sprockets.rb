module JsTextRails
  # Register transformer in Sprockets and fix common issues.
  class TextSprockets
    def self.register_transformer(transformer)
      @transformer = transformer
    end

    # Sprockets 3 and 4 API
    def self.call(input)
      source = input[:data]
      run(source)
    end

    # Transform `text` into a JS string.
    def self.run(text)
      @transformer.transform(text)
    end

    # Register transformer in Sprockets 2 / 3 / 4 API
    def self.install(env)
      if ::Sprockets::VERSION.to_f < 4
        args = [".#{@extension}", self]
        args << { mime_type: 'application/javascript', silence_deprecation: true } if ::Sprockets::VERSION.to_f >= 3
        env.register_engine(*args)
      else
        # TODO: Is the original extension for the mime type also needed as an
        # extension?  (Does the array override the old one, or get merged?)
        env.register_mime_type(@mime_type, extensions: [".jstext.#{@extension}"])
        env.register_transformer(@mime_type, 'application/javascript+function', self)
      end
    end

    # Register transformer in Sprockets 2 / 3 / 4 API
    def self.uninstall(env)
      if ::Sprockets::VERSION.to_f < 4
        args = [".#{@extension}", self]
        args << { mime_type: 'application/javascript', silence_deprecation: true } if ::Sprockets::VERSION.to_f >= 3
        env.unregister_engine(*args)
      else
        # TODO: Is the original extension for the mime type also needed as an
        # extension?  (What would be the consequences of unregistering?)
        env.unregister_mime_type(@mime_type, extensions: [".jstext.#{@extension}"])
        env.unregister_transformer(@mime_type, 'application/javascript+function', self)
      end
    end

    # Sprockets 2 API new and render
    def initialize(filename, &block)
      @source = block.call
    end

    # Sprockets 2 API new and render
    def render(_, _)
      self.class.run(@source)
    end
  end
end
