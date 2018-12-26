
class EtherscanService
  def self.fetch_transactions(address)
    # TODO: Clean up
    resp = JSON.parse(
      RestClient.get(
        self.transaction_endpoint(address)
      )
    )
    if resp.present? && resp['result'].present?
      resp['result']
    else
      Rails.loigger.error("[FAIL] to fetch transactions from etherscan.")
      []
    end
  end

  def self.transaction_endpoint(address)
    "#{api_host}api?module=account&action=txlist&address=#{address}&sort=desc&apikey=#{api_key}&offset=20&page=1"
  end

  def self.api_host
    @api_host ||= 'https://api.etherscan.io/'
  end

  def self.api_key
    @api_key ||= ENV['ETHERSCAN_KEY']
  end
end