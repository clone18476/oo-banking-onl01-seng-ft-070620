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
      withdrawl_complete = @sender.withdrawl(@amount) # uses withdrawl method defined in BankAccount
      if withdrawl_complete && self.valid?   #    each transfer can only happen once
          binding.pry
        @receiver.deposit(@amount)
        @status = "complete"
      else
        @status = "rejected"   #    rejects a transfer if the sender does not have enough funds (does not have a valid account)
        "Transaction rejected. Please check your account balance."
      end
    end
  end

  def reverse_transfer   #    can reverse a transfer between two accounts
    # binding.pry
    if @status == "complete"     #     it can only reverse executed transfers
      @status = "pending"
      temp_receiver = @sender
      temp_sender =  @receiver
      @sender = temp_sender
      @receiver = temp_receiver
      self.execute_transaction
      if @status == "complete"
        @status = "reversed"
      end
    end

  end

end 
