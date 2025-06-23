class Employee < ApplicationRecord
  has_many :reporting_relationships_as_subordinate,
           class_name: 'ReportingRelationship',
           foreign_key: :subordinate_id

  has_many :supervising_employees,
           through: :reporting_relationships_as_subordinate,
           source: :supervisor,
           source_type: 'Employee'

  has_many :supervising_groups,
           through: :reporting_relationships_as_subordinate,
           source: :supervisor,
           source_type: 'Group'

  has_many :reporting_relationships_as_supervisor,
           as: :supervisor,
           class_name: 'ReportingRelationship'

  has_many :subordinates,
           through: :reporting_relationships_as_supervisor,
           source: :subordinate

  has_many :group_memberships
  has_many :groups, through: :group_memberships
end
