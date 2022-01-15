module Tradeup
  require 'httparty'
  def Tradeup.get_rate(symbol_one,symbol_two)
    response = HTTParty.get('https://tradeup.currconv.com/api/v7/convert',
                 {query: { apiKey:ENV['currency_converter_api'] ,
                           q:["#{symbol_one}_#{symbol_two}"].join(","), compact:'ultra'}}).body
    JSON.parse(response,symbolize_names: true).values[0].to_f
  end

  # returns a huge hash of currency conversion rates
  def Tradeup.get_rates(pairs)
    pairs.uniq!
    rates = {}
    pairs = pairs.each_slice(250).to_a

    pairs.each do |pairs_slice|
      pairs_strings = []
      pairs_slice.each do |symbol|
        new_conversion_symbol = "#{symbol[0]}_#{symbol[1]}"
        pairs_strings.append new_conversion_symbol
      end
      response = HTTParty.get('https://tradeup.currconv.com/api/v7/convert',
                              {query: { apiKey:ENV['currency_converter_api'] ,
                                        q:pairs_strings.join(","), compact:'ultra'}}).body
      rates.merge!(JSON.parse(response,symbolize_names: true))
    end
    return rates
  end

  def Tradeup.select_rate(symbol_one, symbol_two,rates)
    puts "rates is"
    puts rates.to_s
    rates.select { |rate| rate.include?("#{ symbol_one }_#{symbol_two}".to_sym) }[0]
  end

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
    def Seeding.connect_to_test_database
      # https://docs.digitalocean.com/products/app-platform/how-to/use-environment-variables/#component-specific-variables
      # Mongo::Client.new([ ->{ENV['DATABASE_URL'] || '127.0.0.1:27017'} ],
      #                   :database => ->{ENV['DATABASE'] || 'Tradeup'}
      # )
      Mongoid.load!('config/mongoid-test.yml')
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
      rates = Tradeup.get_rates pairs # get a  snapshot of all possible exhange rates
      rates.freeze
      documents = Parallel.map(pairs,in_threads:270) do |pair|
       {symbol_one:pair[0].to_s,symbol_two:pair[1].to_s,amount: rates["#{pair[0].to_s}_#{pair[1].to_s}".to_sym]}
      end
      Models::Pair.create! documents
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
