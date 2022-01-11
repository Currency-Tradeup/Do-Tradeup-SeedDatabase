module Tradeup
  module Database
    module Seeding

    require 'mongoid'
    require 'Tradeup/Database/Models'

    def connect_to_database
      # https://docs.digitalocean.com/products/app-platform/how-to/use-environment-variables/#component-specific-variables
      Mongo::Client.new([ ->{ENV['DATABASE_URL'] || '127.0.0.1:27017'} ],
                        :database => ->{ENV['DATABASE'] || 'Tradeup'}
      )
    end

    def get_currencies

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
