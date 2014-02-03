class Event
  
  attr_accessor :address 
  attr_accessor :bw_id
  attr_accessor :category
  attr_accessor :cost
  attr_accessor :description
  attr_accessor :title
  attr_accessor :venue
  attr_accessor :date
  attr_accessor :phone
  attr_accessor :bs_id 
  
  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value) if respond_to?("#{key}=")
    end
  end
end
