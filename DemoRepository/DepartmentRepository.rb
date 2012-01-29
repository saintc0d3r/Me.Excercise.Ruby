class DepartmentRepository
  def initialize
    @departments = Array.new
  end

  def Add(newDepartment)
    selectedDepartments = @departments.select{|department| department.Code == newDepartment.Code &&
                                        department.Name == newDepartment.Name}
    if (newDepartment != nil && selectedDepartments.length == 0)
      @departments.push(newDepartment)
      return true, ""
    end
    return false, "Argument is null or the data is already existing."
  end

  def Find(code)
    selectResult = @departments.select{|dept| dept.Code == code}
    if selectResult.length > 0
      return selectResult[0]
    end
    return nil
  end

  def Update(target)
    if (target.nil?)
      return false, "Argument is nil."
    end

    dept = Find(target.Code)
    if (dept.nil?)
      return false, "#{target} does not exist."
    end

    dept.Name = target.Name
    return true, "Update success."
  end

  def GetAll
    return @departments
  end
end