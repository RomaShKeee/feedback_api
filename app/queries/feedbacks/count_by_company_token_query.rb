module Feedbacks
  class CountByCompanyTokenQuery
    def self.call(company_token, relation = Feedback.all)
      Rails.cache.fetch("feedbacks/#{company_token}/count", expires_in: 12.hours) do
        relation.where(company_token: company_token).count
      end
    end
  end
end
