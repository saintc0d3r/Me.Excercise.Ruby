class Department
  attr_accessor :Code, :Name

  def initialize(code, name)
    @Code = code
    @Name = name
  end

  def to_s
    "Department ( Name: #{@Name}; Code: #{@Code} )"
  end
end