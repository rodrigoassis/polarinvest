class InvestmentTypes::Saving < Investment
  # Method required for routes identify that 
  # Saving it's just a type of Investment
  # WARNING! NOT SURE WHAT ELSE THIS HACK MESS UP
  def self.model_name
    Investment.model_name
  end

  # Extract the real class name without any module
  def self.clean_name
    self.name.split('::').last
  end
end
