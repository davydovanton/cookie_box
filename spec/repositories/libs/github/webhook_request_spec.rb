# frozen_string_literal: true

RSpec.describe Repositories::Libs::Github::WebhookRequest do
  include Dry::Monads::Either::Mixin

  let(:lib) { described_class.new(http_request: http_request) }
  let(:http_request) { double(:http_request, post: response) }

  subject { lib.call(token: '123', repository: repository) }

  let(:repository) { Repository.new(full_name: 'davydovanton/cookie_box') }

  context 'when response success' do
    let(:response) { Net::HTTPSuccess.new('1.1', 200, 'test') }

    it { expect(subject).to be_right }

    it 'calls http library' do
      expect(http_request).to receive(:post).with(
        'https://api.github.com/repos/davydovanton/cookie_box/hooks?access_token=123',
        name: 'web',
        active: true,
        events: ['issues'],
        config: {
          url: 'http://cookie-box.cluster.davydovanton.com/webhooks/github',
          content_type: 'json'
        }
      )

      subject
    end
  end

  context 'when response failure' do
    let(:response) { double(:failed_response, body: :error) }

    it { expect(subject).to be_failure }
  end
end
