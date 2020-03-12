# frozen_string_literal: true

class FeedbacksController < ApplicationController

  # GET /feedbacks
  def index
    @feedbacks = Feedback.where(company_token: company_token)
    render json: @feedbacks
  end

  # GET /feedbacks/1
  def show
    @feedback = Feedbacks::FindByCompanyAndNumberQuery.call(company_token, params[:id])
    render json: @feedback
  end

  # POST /feedbacks
  def create
    @feedback_creation = Feedbacks::CreationService.call(feedback: feedback_params,
                                                         state: state_params)
    if @feedback_creation.success?
      render json: @feedback_creation.value!, status: :created
    else
      render json: { error: @feedback_creation.failure }, status: :unprocessable_entity
    end
  end

  def count
    @feedbacks_count_query = Feedbacks::CountByCompanyTokenQuery.call(company_token)

    render json: { count: @feedbacks_count_query }
  end

  private

  # Only allow a trusted parameter "white list" through.
  def feedback_params
    params.require(:feedback).permit(:company_token, :priority)
  end

  def state_params
    params.require(:state).permit(:device, :os, :memory, :storage)
  end
end
