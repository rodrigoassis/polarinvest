class AssetTypes::Fund < Asset
  # Method required for routes identify that 
  # Fund it's just a type of Asset
  # WARNING! NOT SURE WHAT ELSE THIS HACK MESS UP
  def self.model_name
    Asset.model_name
  end
  
end
