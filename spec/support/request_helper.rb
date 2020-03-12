module RequestHelper
  extend ActiveSupport::Concern

  def json_body
    @json_body ||= JSON.parse(response.body)
    @json_body.is_a?(Hash) ? @json_body.with_indifferent_access : @json_body
  end
end
