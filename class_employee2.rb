=begin
Here we begin to explore some of the great advantages of reader, writer and
accessor metods. We will also work with a powerful method called super, which 
allows us to inherit traits of a paticular method in another class with but both
methods must have "THE SAME NAME!". Let's see the examle below.
=end

class Employee
  attr_reader :first_name, :last_name, :salary #allows user to only see, not set value.
  attr_writer :active # writer method allows you to change the value of attribute, but not see it.
  attr_accessor #Allows you to both see and change the value of the attribute
  #(intentionally left blank for example)
  def initialize(input_options)
    @first_name = input_options[:first_name] #variable set to the value of :first_name key.
    @last_name = input_options[:last_name]
    @salary = input_options[:salary]
    @active = true
  end
=begin
Inputting arguments inside of an initialize method is most widely done in a hash
format. A common name for the hash is either input or input_options, as seen in 
the above method. The variables are set to the value of the keys.  See above.
The important thing to remember here is when you are seting the variables, you
are doing so with the :befor the keyname, but when creating the new instance with 
initialize you do so with the : after the keyname, like so:
employee1 = Employee.new({first_name: "Majora", last_name: "Carter", salary: 80000, active: true})
=end

  def print_info
    puts "#{@first_name} #{@last_name} makes #{@salary} a year and their status is #{@active}"
  end

  def give_annual_raise
    @salary = 1.05 * @salary
  end
end

class Manager < Employee
  attr_reader :employees 
  def initialize(input_options)
    super(input_options) #inherits the initialize code from Employee class
    @employees = input_options[:employees] #adding of more attributes which only this
    #initialize method can use.
  end
=begin
The super method is super important.  As long as both methods have the same name
it allows us to inherit all the code of the method in the parentclass(Employee in this case),
and use it's attributes, while allowing the adding of more attributes that can only be used
by the class that is inheriting the method via super.  Super can be used for any method.  Some
guidelines of edicate to follow are simple:
1. make sure the name of the argument (input_options) in this case, is used consistently
through out the method, including in super, even though it will work without it.
=end
  def send_report
    puts "Sending email..."
    # use email sending library...
    puts "Email sent!"
  end

  def give_all_raises 
    @employees.each {|employee| employee.give_annual_raise}
  end
  
  def fire_all_employees 
    @employees.each {|employee| employee.active = false}
    #the above code would have given us an error if inside the Employee class we 
    #set active to read only ex:(attr_reader :first_name, :last_name, :salary :active)
    #and got rid of the writer method ex:(attr_writer :active)
    #the following will be the error message in that scenario: 
    #undefined method `active=' for #<Employee:0x0000000216e9f8>
    #Also note that the write method(attr_writer) will only set the value, so if
    #you wanted to see the value and you called .active on a new instance of an employee 
    #class, you get another error:  undefined method `active' for #<Employee:0x0000000176e138>
    #for both reading and writting priveledges, please use attr_accessor.
  end
end

employee1 = Employee.new({first_name: "Majora", last_name: "Carter", salary: 80000, active: true})
employee2 = Employee.new(first_name: "Danilo", last_name: "Campos", salary: 70000, active: true)
manager = Manager.new(
  first_name: "Saron", 
  last_name: "Yitbarek", 
  salary: 100000, 
  active: true, 
  employees: [employee1, employee2]
  )

manager.print_info  #Saron Yitbarek makes 100000 a year and their status is true
employee1.print_info#Majora Carter makes 80000 a year and their status is true
employee2.print_info#Danilo Campos makes 70000 a year and their status is true
manager.send_report #Sending email...Email sent!
puts "***************************************"
manager.give_all_raises #employees salary changes.
employee1.print_info#Majora Carter makes 84000.0 a year and their status is true
employee2.print_info#Danilo Campos makes 73500.0 a year and their status is true
puts "***************************************"
manager.fire_all_employees #employees status changes from true to false.
employee1.print_info #Majora Carter makes 84000.0 a year and their status is false
employee2.print_info #Danilo Campos makes 73500.0 a year and their status is false
puts "***************************************"
puts employee1.active 
# undefined method `active' for #<Employee:0x0000000176e138> because only writer
# method was used for :active
