# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Webhooks::Views::ApplicationLayout, type: :view do
  let(:layout)   { Webhooks::Views::ApplicationLayout.new(template, {}) }
  let(:rendered) { layout.render }
  let(:template) { Hanami::View::Template.new('apps/webhooks/templates/application.html.slim') }

  it 'contains application name' do
    expect(rendered).to include('Webhooks')
  end
end
