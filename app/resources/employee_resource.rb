class EmployeeResource < ApplicationResource
  type :employees
  model Employee

  belongs_to :department,
             scope: -> { Department.all },
             foreign_key: :department_id,
             resource: DepartmentResource

  has_many :positions,
    scope: -> { Position.all },
    foreign_key: :employee_id,
    resource: PositionResource

  def update(attrs)
    photo    = attrs.delete(:profile_photo)
    employee = super(attrs)
    attach(employee, :profile_photo, photo) if photo
    employee
  end

  private

  # All below logic can be moved to a utility class if needed

  def attach(record, type, params)
    file = tempfile_for(params[:data])
    record.send(type).attach(io: file, filename: params[:filename])
  end

  def tempfile_for(data)
    file = Tempfile.new('temp')
    file.binmode
    file.write(Base64.decode64(data))
    file.close
    file.open
    file
  end
end
