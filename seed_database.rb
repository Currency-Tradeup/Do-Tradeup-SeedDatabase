module Tradeup
  module Database
    BLACKLIST = [:VEF,:BTC]
    module Seeding

    require 'mongoid'
    require 'Tradeup/Database/Models'
    require 'httparty'
    require 'parallel'


    def Seeding.connect_to_database
      # https://docs.digitalocean.com/products/app-platform/how-to/use-environment-variables/#component-specific-variables
      # Mongo::Client.new([ ->{ENV['DATABASE_URL'] || '127.0.0.1:27017'} ],
      #                   :database => ->{ENV['DATABASE'] || 'Tradeup'}
      # )
      Mongoid.load!('config/mongoid.yml')
    end

    def Seeding.get_currencies
      currencies_response = JSON.parse(HTTParty.get('https://tradeup.currconv.com/api/v7/currencies',{ query: { apiKey:ENV['currency_converter_api'] } }).body,symbolize_names: true)[:results].keys.to_a
      currencies_response - BLACKLIST
    end

    def Seeding.generate_pairs(currencies)
      pairs = Parallel.map(currencies) do |currency|
        repeated = [currency] * currencies.count
        repeated.zip(currencies.to_a)
      end
      pairs.flatten!(1)
    end

    def Seeding.seed_pairs(pairs)
      Models::Pair
    end

    def Seeding.generate_chains(start_currency,pairs,end_currency)

    end

    def Seeding.seed_chains(chains)
      Models::Chain
    end

    if __FILE__ == $0
      pairs = generate_pairs(get_currencies)
      seed_pairs(pairs)
      seed_chains(generate_chains('GBP',pairs,'GBP'))
    end
    end
  end
end
