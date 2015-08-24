class Spree::StoreCredit < ActiveRecord::Base
  validates :amount, :presence => true, :numericality => true
  validates :reason, :presence => true
  validates :user, :presence => true

  if Spree.user_class
    belongs_to :user, :class_name => Spree.user_class.to_s
  else
    belongs_to :user
  end

  before_save :init_remaining_amount

  private
    def init_remaining_amount
      self.remaining_amount = amount if new_record? && remaining_amount == 0.0
    end
end
