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

  def fetch_transactions(format_response = false)
    transactions = EtherscanService.fetch_transactions(address)
    format_response ? format_transaction(transactions) : transactions
  end

  private

  def format_transaction(fetched_transactions)
    fetched_transactions.map do |t|
      {
        amount: t['value'],
        type: t['from'] == address ? :outgoing : :incoming,
        date: DateTime.strptime(t['timeStamp'],'%s')
      }
    end
  end
end
