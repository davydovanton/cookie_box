
# frozen_string_literal: true

module Mock
  class SuccessListOperation < Core::Operation
    def call(*)
      Success([])
    end
  end

  class FailListOperation < Core::Operation
    def call(*)
      Failure(:some_error)
    end
  end
end
