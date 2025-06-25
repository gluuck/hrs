class OrgChartController < ApplicationController
  def get_org_chart
    @nodes = []

    Employee.includes(:subordinates).find_each do |emp|
      @nodes << {
        id: "employee_#{emp.id}",
        name: emp.name,
        title: 'Сотрудник',
        pid: emp.reporting_relationships_as_subordinate.map do |rel|
          "#{rel.supervisor_type.downcase}_#{rel.supervisor_id}"
        end
      }
    end

    Group.includes(:subordinates).find_each do |group|
      @nodes << {
        id: "group_#{group.id}",
        name: group.name,
        title: 'Группа',
        pid: group.reporting_relationships_as_supervisor.map do |rel|
          "#{rel.supervisor_type.downcase}_#{rel.supervisor_id}"
        end
      }
    end

    render json: @nodes.pluck(:id, :name, :title, :pid) do |id, name, title, pid|
      { id: id, name: name, title: title, pid: pid }
    end
  end
end
