module Supervisorable
  extend ActiveSupport::Concern

  included do
    has_many :reporting_relationships_as_supervisor,
             as: :supervisor,
             class_name: 'ReportingRelationship',
             dependent: :destroy
  end

  def all_subordinates
    reporting_relationships_as_supervisor.includes(:subordinate).map(&:subordinate)
  end
end
