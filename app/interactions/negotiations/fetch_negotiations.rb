class FetchNegotiations < ApplicationInteractor
  string :type, default: nil
  integer :page, default: 1
  integer :per_page, default: 25
  validates :per_page, numericality: { less_than_or_equal_to: 100 }

  def execute
    scope = Negotiation.all
    scope = scope.where(type: type) if type.present?
    scope = scope.page(page).per(per_page)
    scope
  end
end
