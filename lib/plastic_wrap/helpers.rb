module PlasticWrap
  module Helpers
    extend ActiveSupport::Concern

    puts '-- DEBUG plastic_wrap -- Helpers'
    puts '-- DEBUG plastic_wrap -- start included'

    included do
      puts '-- DEBUG plastic_wrap -- not logged -- inside helpers included'
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

      attr_accessor :output_buffer

      def config
        if use_mailer_config?
          ActionMailer::Base.config
        else
          ActionController::Base.config
        end
      end

      def use_mailer_config?
        false
      end
    end

    puts '-- DEBUG plastic_wrap -- end included'
  end
end
