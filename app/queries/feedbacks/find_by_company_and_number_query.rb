module Feedbacks
  class FindByCompanyAndNumberQuery
    def self.call(company_token, number, relation = Feedback.all)
      relation.find_by(company_token: company_token, number: number)
    end
  end
end
