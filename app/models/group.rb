class Group < ApplicationRecord
  has_many :group_memberships
  has_many :employees, through: :group_memberships

  has_many :reporting_relationships_as_supervisor,
           as: :supervisor,
           class_name: 'ReportingRelationship'

  has_many :subordinates,
           through: :reporting_relationships_as_supervisor,
           source: :subordinate
end
