module Feedbacks
  class GenerateNumberService
    def self.call(company_token)
      number = Rails.cache.fetch("feedbacks/#{company_token}/last_number")
      number ||= Feedback.where(company_token: company_token).pluck(:number).max
      number = number.to_i.succ
      Rails.cache.write("feedbacks/#{company_token}/last_number", number)
      number
    end
  end
end
