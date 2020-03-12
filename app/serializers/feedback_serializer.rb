class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :number, :priority

  # has_many :lines
end
