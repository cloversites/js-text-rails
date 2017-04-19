module JsTextRails
  class Railtie < ::Rails::Railtie
    config.js_text_rails = ActiveSupport::OrderedOptions.new

    if config.respond_to?(:assets) and not config.assets.nil?
      config.assets.configure do |env|
        JsTextRails.install(env, params)
      end
    else
      initializer :setup_js_text, group: :all do |app|
        if defined? app.assets and not app.assets.nil?
          JsTextRails.install(app.assets, params)
        end
      end
    end

    def params
      hash = {}
      hash[:namespace] = config.js_text_rails.namespace if not config.js_text_rails.namespace.nil?
      hash
    end
  end
end
