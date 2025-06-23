class ReportingRelationship < ApplicationRecord
  belongs_to :subordinate, class_name: 'Employee'
  belongs_to :supervisor, polymorphic: true

  attribute :connection_type, :string
end
