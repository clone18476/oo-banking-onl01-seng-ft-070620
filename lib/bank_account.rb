class BankAccount

  attr_accessor :balance, :status
  attr_reader :name

      # can initialize a Bank Account (an instance of BankAccount Class)
  def initialize(name)  # initializes with a name
    @name = name        # can't change its name
    @balance = 1000     # always initializes with balance of 1000
    @status = "open"    # always initializes with a status of 'open'
  end 
  
  def deposit(money)    # can deposit money into its account
    @balance += money
  end

  def display_balance    # can display its balance 
    "Your balance is $#{@balance}."
  end 
  
  def valid?      #  is valid with an open status and a balance greater than 0
    @status == "open" && @balance > 0 
  end 
  
  def close_account     # can close its account 
    @status = "closed"
  end 
  
  def withdrawl(amount)
    if @status == "open" && @balance >= amount
        @balance -= amount
        return true
      end
      false
    end  
  
  
  
end
