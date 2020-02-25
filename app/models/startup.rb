require_relative 'funding_round'


class Startup
    
    attr_accessor :name, :domain
    attr_reader :founder

    @@all = []

    def initialize(name, founder, domain)
        @name = name
        @founder = founder
        @domain = domain

        @@all << self
    end

    def pivot(domain, name)
        # Given a string of a domain and a string of a name, change the domain and name of the startup.
        self.domain = domain
        self.name = name
    end

    def sign_contract(venture_capitalist, investment_type, investment_amount)
        # Given a venture capitalist object, type of investment (as a string), and the amount invested (as a float), creates a new funding round and associates it with that startup and venture capitalist.
        FundingRound.new(self, venture_capitalist, investment_type, investment_amount)
    end

    def funding_rounds
        FundingRound.all.select { |funding_round| funding_round.startup == self }
    end

    def num_funding_rounds
        # Returns the total number of funding rounds that the startup has gotten
        funding_rounds.length
    end

    def total_funds
        # Returns the total sum of investments that the startup has gotten
        
        # OPTION 1 (the long way)
        # funding_rounds.reduce(0) { |total, funding_round| total + funding_round.investment }
    
        # OPTION 2 (the short way)
        funding_rounds.sum { |funding_round| funding_round.investment }

    end

    def investors
        # Returns a unique array of all the venture capitalists that have invested in this company
        funding_rounds.map { |funding_round| funding_round.venture_capitalist }.uniq
    end

    def big_investors
        # Returns a unique array of all the venture capitalists that have invested in this company and are in the Trés Commas club
        investors.select { |vc| vc.in_tres_commas_club? }
    end

    def self.all
        @@all
    end

    def self.find_by_founder(founder_name)
        # Given a string of a founder's name, returns the first startup whose founder's name matches
        self.all.find { |startup| startup.founder == founder_name}
    end

    def self.domains
        # Should return an array of all of the different startup domains 
        self.all.map { |startup| startup.domain }.uniq
    end
    
end
