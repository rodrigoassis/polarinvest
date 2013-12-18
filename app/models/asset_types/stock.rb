class AssetTypes::Stock < Asset
  # Method required for routes identify that 
  # Stock it's just a type of Asset
  # WARNING! NOT SURE WHAT ELSE THIS HACK MESS UP
  def self.model_name
    Asset.model_name
  end
  
end
