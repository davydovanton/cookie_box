
module Mock
  class SuccessListOperation < Core::Operation
    def call(*)
      Right([])
    end
  end

  class FailListOperation < Core::Operation
    def call(*)
      Left(:some_error)
    end
  end
end
