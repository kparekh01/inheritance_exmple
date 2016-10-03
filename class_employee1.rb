class Employee
  attr_reader :first_name, :last_name, :salary, :active
  def initialize(input)
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    @salary = input[:salary]
    @active = input[:active]
  end
  def change_status
    @active = !@active
  end
  def print_info
    puts "#{first_name} #{last_name} makes #{salary.to_s} a year."
  end
  def give_annual_raise
    @salary = 1.05 * salary
  end
end

class Manager
  attr_reader :first_name, :last_name, :salary, :active
  def initialize(input)
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    @salary = input[:salary]
    @active = input[:active]
  end
  def change_status
    @active = !@active
  end
  def print_info
    puts "#{first_name} #{last_name} makes #{salary.to_s} a year."
  end
  def give_annual_raise
    @salary = 1.05 * salary
  end
  def send_report #*****ONLY AVAILABLE TO NEW INSTANCE OF MANAGER CLASS!**********
    puts "Preparing to send report..."
    #use a library to send an email
    puts "Report sent!"
  end
end
employee1 = Employee.new({first_name: "Majora", last_name: "Carter", salary: 80000, active: true})
employee2 = Employee.new(first_name: "Danilo", last_name: "Campos", salary: 70000, active: true)
employee1.print_info #Majora Carter makes 80000 a year.

manager = Manager.new(first_name: "Saron", last_name: "Yitbarek", salary: 100000, active: true, employees: [employee1, employee2])
manager.print_info #Saron Yitbarek makes 100000 a year.
# Above is a method from Employee class being used on a new instance of a Manager class, because both classes share the same method!!

manager.send_report #Preparing to send report...Report sent!

employee2.send_report # undefined method `send_report' for #<Employee:0x000000012827f0> (NoMethodError)
#Above is the error you will recieve if you try to use a Manager class method
#on a new instance of an Employee Class.
=begin
above is one way where we can create a manager class , add a method to manager class,
in this case(send_report), which ONLY a new instance of manager can access, but the
problem here is that we are repeating our selves a lot and ruby has a great solution to
this repeating problem called inheritance.  Let's see it in action below:
=end

class Employee #SAME AS ABOVE
  attr_reader :first_name, :last_name, :salary, :active
  def initialize(input)
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    @salary = input[:salary]
    @active = input[:active]
  end
  def change_status
    @active = !@active
  end
  def print_info
    puts "#{first_name} #{last_name} makes #{salary.to_s} a year."
  end
  def give_annual_raise
    @salary = 1.05 * salary
  end
end

class Manager < Employee  #Will still give us same exact results as the first code!
  def send_report #*****ONLY AVAILABLE TO NEW INSTANCE OF MANAGER CLASS!**********
    puts "Preparing to send report..."
    #use a library to send an email
    puts "Report sent!"
  end
end

=begin
This example of inheritance using the < symbol, allows for the Manager class to
inherit all methods and attributes from the Employee class, but will not allow the
Employee class to aceess anthing inside of the Mnager class, thus making the code a
lot less repetetive (or DRY(don't repeat yourself)).
=end
