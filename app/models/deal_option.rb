class DealOption < ActiveRecord::Base
  attr_accessible :buyUrl, :details_description, :discountPercent, :discount_formattedAmount, :expiresAt, :isSoldOut, :maximumPurchaseQuantity, :price_formattedAmount, :soldQuantity, :soldQuantityMessage, :title, :value_formattedAmount

  belongs_to :GrouponDeal
end
