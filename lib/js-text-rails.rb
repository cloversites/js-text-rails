# Transform text files into strings on a global JavaScript object.
module JsTextRails
  autoload :SvgSprockets, 'js-text-rails/svg_sprockets'

  # Add JsText to Sprockets environment in `assets`.
  def self.install(assets, params = {})
    SvgSprockets.register_transformer(svg_transformer)
    SvgSprockets.install(assets)
  end

  # Disable installed JsText.
  def self.uninstall(assets)
    SvgSprockets.uninstall(assets)
  end

  # Cache transformer instances.
  def self.svg_transformer(params = {})
    SvgTransformer.new(params)
  end
end

require_relative 'js-text-rails/svg_transformer'

require_relative 'js-text-rails/railtie' if defined?(Rails)
