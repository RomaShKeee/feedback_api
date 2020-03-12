require 'dry/monads'
module Feedbacks
  class Create
    include Dry::Monads[:result]

    def initialize(params = {})
      @params = params
      @feedback_params = params[:feedback]
      @state_params = params[:state]
    end

    def call
      return Failure('Params is missing') if [@feedback_params, @state_params].all?(&:blank?)

      if persist
        flush_count_cache
        Success(@feedback)
      else
        Failure(error_messages)
      end
    rescue StandardError => e
      Failure(e.message)
    end

    def self.call(*args)
      new(*args).call
    end

    private

    def persist
      Feedback.transaction do
        @feedback = Feedback.new(@feedback_params)
        @state = State.new(@state_params)
        @state.feedback = @feedback

        @feedback.save && @state.save
      end
    end

    def flush_count_cache
      Rails.cache.delete("feedbacks/#{@feedback.company_token}/count")
    end

    def error_messages
      [@feedback, @state].map { |record| record.errors.full_messages }
    end
  end
end
