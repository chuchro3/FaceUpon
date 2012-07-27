class Quote < ActiveRecord::Base
  attr_protected

  validates_presence_of :quote, :author

end
