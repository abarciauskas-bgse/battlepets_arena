class Contest < ApplicationRecord
  validates :battlepets,
    length: {minimum: 2, message: "are too short (minimum is 2)"}
  validates_presence_of :contest_type
  validates_inclusion_of :contest_type, :in => %w( simple )
  validates :battlepet_traits,
    length: {minimum: 1, maximum: 1, message: "are too long or too short (maximum is 1, minimum is 1)"}
end
