module Webhooks::Controllers::Github
  class Create
    include Webhooks::Action

    def call(params)
      self.body = '{}'
    end
  end
end
