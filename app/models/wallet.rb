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

  ADDRSSS_FORMAT = /0x[0-9a-fA-F]+/

  validates :address,
            presence: true,
            length: { is: 42 },
            format: { with: ADDRSSS_FORMAT },
            on: [:create, :update]

  validates :name,
            presence: true,
            on: [:create, :update]

  def fetch_transactions(format_response = false)
    transactions = Rails.cache.fetch("transactions_#{address}", expires_in: 1.minute) do
      EtherscanService.fetch_transactions(address)
    end
    format_response ? format_transactions(transactions) : transactions
  end

  private

  def format_transactions(transactions)
    transactions.map do |transaction|
      {
        type: transaction['from'] == address ? :outgoing : :incoming,
        amount: transaction['value'],
        date: Time.strptime(transaction['timeStamp'], '%s')
      }
    end
  end
end
