class DealOption < ActiveRecord::Base
  attr_protected

  belongs_to :GrouponDeal
end
