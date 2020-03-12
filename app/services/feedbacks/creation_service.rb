require 'dry/monads'
module Feedbacks
  class CreationService
    include Dry::Monads[:result]

    def initialize(params = {})
      @params = params
      @feedback_params = params[:feedback]
      @state_params = params[:state]
      @company_token = @feedback_params[:company_token]
    end

    def call
      return Failure('Params is missing') if [@feedback_params, @state_params, 
                                              @company_token].all?(&:blank?)

      if @number = GenerateNumberService.call(@company_token)
        FeedbackCreationWorker.perform_async(build_params)
        Success(number: @number)
      else
        Failure('Something wrong')
      end
    rescue StandardError => e
      Failure(e.message)
    end

    def self.call(*args)
      new(*args).call
    end

    private



    def build_params
      { feedback: @feedback_params.to_unsafe_h.merge(number: @number),
        state: @state_params.to_unsafe_h }
    end
  end
end
