module ConversationForms
  module Rails
    class Engine < ::Rails::Engine
      initializer 'conversation_forms.assets.precompile' do |app|
        %w(stylesheets javascripts).each do |sub|
          app.config.assets.paths << root.join('assets', sub).to_s
        end

        # sprockets-rails 3 tracks down the calls to `font_path` and `image_path`
        # and automatically precompiles the referenced assets.
      end
    end
  end
end
