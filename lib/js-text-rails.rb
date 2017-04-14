# Transform text files into strings on the global JavaScript `TEXT` object.
module JsTextRails
  autoload :ObjectSprockets, 'js-text-rails/object_sprockets'
  autoload :SvgTextSprockets, 'js-text-rails/svg_text_sprockets'

  # Transform text into a JavaScript string.  See Transformer#transform.
  def self.transform(text)
    text_transformer.transform(text)
  end

  # Add JsText to Sprockets environment in `assets`.
  def self.install(assets, params = {})
    ObjectSprockets.register_transformer(object_transformer(params))
    ObjectSprockets.install(assets)
    SvgTextSprockets.register_transformer(text_transformer)
    SvgTextSprockets.install(assets)
  end

  # Disable installed JsText.
  def self.uninstall(assets)
    ObjectSprockets.uninstall(assets)
    SvgTextSprockets.uninstall(assets)
  end

  # Cache transformer instances.
  def self.object_transformer(params = {})
    ObjectTransformer.new(params)
  end

  # Cache transformer instances.
  def self.text_transformer
    TextTransformer.new
  end
end

require_relative 'js-text-rails/object_transformer'
require_relative 'js-text-rails/text_transformer'

require_relative 'js-text-rails/railtie' if defined?(Rails)
