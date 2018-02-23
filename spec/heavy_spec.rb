require 'spec_helper'
require 'time'

RSpec.describe 'PlasticWrap::Heavy' do
  it 'wraps a class' do
    require 'rails'
    require 'sprockets/railtie'

    class MyApp < Rails::Application; end

    require 'plastic_wrap'

    class Leftovers
      def best_before
        @best_before ||= Time.parse('2018-02-23 15:08:48 -0500')
      end
    end

    class ReadableBestBefore < PlasticWrap.create_wrap(Leftovers)
      def best_before
        super.strftime('%m-%y')
      end
    end

    expect(ReadableBestBefore.wrap(Leftovers.new).best_before).to eq("02-18")
  end
end
