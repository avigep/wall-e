# == Schema Information
#
# Table name: wallets
#
#  id         :bigint(8)        not null, primary key
#  address    :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Wallet < ApplicationRecord
  # FIXME: Add validations
  def transactions
    # TODO add logic to fetch transactions
    []
  end
end
