module JsTextRails
  # Register transformer in Sprockets and fix common issues.
  class ObjectSprockets
    def self.register_transformer(transformer)
      @transformer = transformer
    end

    # Sprockets 3 and 4 API
    def self.call(input)
      name = input[:name].inspect
      data = self.sanitize_data(input[:data])
      run(name, data)
    end

    # Transform `data` into a JS object value at `key`.
    def self.run(key, data)
      @transformer.transform(key, data)
    end

    # Register transformer in Sprockets 2 / 3 / 4 API
    def self.install(env)
      if ::Sprockets::VERSION.to_f < 4
        args = ['.jstext', self]
        args << { mime_type: 'application/javascript', silence_deprecation: true } if ::Sprockets::VERSION.to_f >= 3
        env.register_engine(*args)
      else
        env.register_transformer('application/javascript+function', 'application/javascript', self)
      end
    end

    # Register transformer in Sprockets 2 / 3 / 4 API
    def self.uninstall(env)
      if ::Sprockets::VERSION.to_f < 4
        args = ['.jstext', self]
        args << { mime_type: 'application/javascript', silence_deprecation: true } if ::Sprockets::VERSION.to_f >= 3
        env.unregister_engine(*args)
      else
        env.unregister_transformer('application/javascript+function', 'application/javascript', self)
      end
    end

    # Sprockets 2 API new and render
    def initialize(filename, &block)
      @filename = filename
      @data = block.call
    end

    # Sprockets 2 API new and render
    def render(_, _)
      name = @filename # TODO: Should be same format as `input[:name]`.
      data = self.class.sanitize_data(@data)
      self.class.run(name, data)
    end

    private

    def self.sanitize_data(data)
      # From sprockets/lib/sprockets/jst_processor.rb:
      data.gsub(/$(.)/m, "\\1  ").strip
    end
  end
end
