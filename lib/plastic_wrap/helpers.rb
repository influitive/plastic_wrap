module PlasticWrap
  module Helpers
    extend ActiveSupport::Concern

    included do
      include ActionView::Helpers
      include Rails.application.routes.url_helpers

      if Rails::VERSION::MAJOR >= 4
        include Sprockets::Rails::Helper

        def assets_manifest
          ActionView::Base.assets_manifest
        end

        def assets_environment
          ActionView::Base.assets_environment
        end

        def assets_prefix
          Rails.application.assets.context_class.assets_prefix
        end

        def digest_assets
          Rails.configuration.assets.digest
        end
      else
        include Sprockets::Helpers::RailsHelper
      end

      attr_accessor :options, :output_buffer

      def config
        Rails.application.config.action_controller
      end
    end
  end
end
