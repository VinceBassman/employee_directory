class PositionResource < ApplicationResource
  type :positions
  model Position

  allow_filter :title_prefix do |scope, value|
    scope.where(["title LIKE ?", "#{value}%"])
  end

  belongs_to :employee,
             scope: -> { Employee.all },
             foreign_key: :employee_id,
             resource: EmployeeResource
end
