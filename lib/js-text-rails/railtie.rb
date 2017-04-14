module JsTextRails
  class Railtie < ::Rails::Railtie
    if config.respond_to?(:assets) and not config.assets.nil?
      config.assets.configure do |env|
        JsTextRails.install(env)
      end
    else
      initializer :setup_js_text, group: :all do |app|
        if defined? app.assets and not app.assets.nil?
          JsTextRails.install(app.assets)
        end
      end
    end
  end
end
