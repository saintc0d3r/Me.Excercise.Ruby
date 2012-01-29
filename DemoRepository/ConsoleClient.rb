require_relative ("Department")
require_relative("DepartmentRepository")

class ConsoleClient

  def initialize
    @repository = DepartmentRepository.new
  end

  def GetUserInput(inputLabel)
    print inputLabel
    enteredValue = gets.strip
    if ( enteredValue.empty? )
      GetUserInput(inputLabel)
    else
      enteredValue
    end
  end

  def ShowEnterDataScreen
    puts
    code = GetUserInput("Code:")
    name = GetUserInput("Name:")
    newDepartment = Department.new(code, name)
    success, error = @repository.Add(newDepartment)
    if (success)
      puts "Add a new #{newDepartment}, is success."
    else
      puts "Unable to add #{newDepartment}. Error:#{error}"
    end
  end

  def ShowEditDataScreen
      puts "Load a Department to Edit"
      puts "-------------------------"
      code = GetUserInput("Enter the Code:")
      puts "Loading ..."
      departmentToEdit = @repository.Find(code)
      if (departmentToEdit.nil?)
        puts "Error: Department with code='#{code}' does not exist."
        return
      end

      puts "Code          : #{departmentToEdit.Code}"
      puts "Current Name  : #{departmentToEdit.Name}"
      departmentToEdit.Name = GetUserInput("Enter new Name: ")
      puts "Updating ..."
      success, error = @repository.Update(departmentToEdit)
      if (success)
        puts "Updating #{departmentToEdit} is success."
      else
        puts "Unable to update #{departmentToEdit}. Error:#{error}"
      end
  end

  def PrintAllDataOnScreen
      puts "List of available Departments:"
      puts "------------------------------"
      @repository.GetAll().each do |department|
        puts "#{department}"
      end
  end

  def ShowMenuHeader
      puts "Actions Menu :"
      puts "-------------"
  end

  def ShowMainMenu
      puts "1. Enter Department."
      puts "2. Edit a Department. "
      puts "3. Print all departments."
      print "Type the number to pick the action or 'q' to end:"
      action = gets

      if action =~ /1/
        ShowEnterDataScreen()
      elsif action =~ /2/
        ShowEditDataScreen()
      elsif action =~ /3/
        PrintAllDataOnScreen()
      elsif action =~ /q/
        return
      end
      puts "\n\n"
      ShowMainMenu()
  end

  def run
    # Show header at once
    ShowMenuHeader()

    # Show main menu
    ShowMainMenu()
  end
end