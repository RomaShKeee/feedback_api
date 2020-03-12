class ApplicationController < ActionController::API

  private

  def company_token
    request.headers['X-COMPANY-TOKEN']
  end
end
