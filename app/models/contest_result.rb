class ContestResult < ApplicationRecord
  belongs_to :contest
  validates_presence_of :contest, :winner, :loser
end
