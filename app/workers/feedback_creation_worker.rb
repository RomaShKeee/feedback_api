class FeedbackCreationWorker
  include Sidekiq::Worker

  def perform(params)
    params = params
    feedback_params = params[:feedback]
    state_params = params[:state]
    Feedbacks::Create.call(feedback: feedback_params, state: state_params)
  end
end
