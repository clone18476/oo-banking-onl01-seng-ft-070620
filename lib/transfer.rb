class Transfer
  
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount) #     can initialize a Transfer 
    @sender = sender                       #     initializes with a sender
    @receiver = receiver                   #     initializes with a receiver  
    @amount = amount                       #     always initializes with a status of 'pending' 
    @status = "pending"                    #     initializes with a transfer amount    
 
  end
  
  def valid?   # can check that both accounts are valid 
    @sender.valid? && @receiver.valid?
  end 
  
  def execute_transaction    #can execute a successful transaction between two accounts
    #binding.pry
    if @status != "complete"  # if the status is not complete, so if it's pending this will pass 
       # binding.pry
      withdrawl_complete = @sender.withdrawl(@amount) # uses withdrawl method defined in BankAccount class 
      if withdrawl_complete && self.valid?   #    each transfer can only happen once
          binding.pry
        @receiver.deposit(@amount)   # uses deposit method defined in BankAccount class 
        @status = "complete"   # transaction status is complete once it's eexecuted
      else
        @status = "rejected"   #    rejects a transfer if the sender does not have enough funds (does not have a valid account)
        "Transaction rejected. Please check your account balance."
      end
    end
  end

  def reverse_transfer   #    can reverse a transfer between two accounts
    # binding.pry         #     it can only reverse executed transfers
    if @status == "complete"    # when reversing transfer change account status from complete back to pending 
      @status = "pending"
      temp_receiver = @sender    # sets sender variable to a value
      temp_sender =  @receiver   # sets receiver variable to a value 
      @sender = temp_sender      # sets sender to the same value as reciever variable 
      @receiver = temp_receiver  # sets receiver to the same value as sender variable
      self.execute_transaction   # then executes the transaction using the variables set to these new interacting values 
      if @status == "complete"   # once status changes to complete at end of self.execute_transaction it is changed again to reversed 
        @status = "reversed"     
      end
    end

  end

end 
