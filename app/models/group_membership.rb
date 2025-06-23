class GroupMembership < ApplicationRecord
  belongs_to :employee
  belongs_to :group

  attribute :role, :string
end
