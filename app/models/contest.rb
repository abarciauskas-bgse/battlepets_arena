class Contest < ApplicationRecord
  validates :battlepets, :length => {minimum: 2}
  validates_presence_of :contest_type
end
