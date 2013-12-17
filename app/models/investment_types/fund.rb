class InvestmentTypes::Fund < Investment
  # Method required for routes identify that 
  # Fund it's just a type of Investment
  # WARNING! NOT SURE WHAT ELSE THIS HACK MESS UP
  def self.model_name
    Investment.model_name
  end

end
