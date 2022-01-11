module Tradeup
  module Database
    BLACKLIST = [:VEF,:BTC]
    module Seeding

    require 'mongoid'
    require 'Tradeup/Database/Models'
    require 'httparty'


    def connect_to_database
      # https://docs.digitalocean.com/products/app-platform/how-to/use-environment-variables/#component-specific-variables
      Mongo::Client.new([ ->{ENV['DATABASE_URL'] || '127.0.0.1:27017'} ],
                        :database => ->{ENV['DATABASE'] || 'Tradeup'}
      )
    end

    def get_currencies
      currencies_response = JSON.parse(HTTParty.get('https://tradeup.currconv.com/api/v7/currencies',{ query: { apiKey:ENV['currency_converter_api'] } }).body,symbolize_names: true)[:results].keys.to_a
      whitelist  = currencies_response - BLACKLIST
      symbols = Parallel.map(whitelist,{in_threads:12}) do |symbol|
        {symbol: symbol}
      end
      return symbols
    end

    def generate_pairs

    end

    def seed_pairs(pairs)
      Models::Pair
    end

    def generate_chains(start_currency,pairs,end_currency)

    end

    def seed_chains(chains)
      Models::Chain
    end

    if __FILE__ == $0
      pairs = generate_pairs
      seed_pairs(pairs)
      seed_chains(generate_chains('GBP',pairs,'GBP'))
    end
    end
  end
end
