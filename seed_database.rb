module Tradeup
  module Database
    module Seeding

    require 'mongoid'

    def get_currencies

    end

    def generate_pairs

    end

    def seed_pairs(pairs)

    end

    def generate_chains(start_currency,pairs,end_currency)

    end

    def seed_chains(chains)

    end

    if __FILE__ == $0
      pairs = generate_pairs
      seed_pairs(pairs)
      seed_chains(generate_chains('GBP',pairs,'GBP'))
    end
    end
  end
end
