require_relative 'funding_round'


class VentureCapitalist

    attr_accessor :total_worth
    attr_reader :name

    @@all = []

    def initialize(name, total_worth)
        @name = name
        @total_worth = total_worth

        @@all << self
    end

    def in_tres_commas_club?
        total_worth >= 10**9
    end

    def offer_contract(startup, investment_type, investment_amount)
        # given a startup object, type of investment (as a string), and the amount invested (as a float), creates a new funding round and associates it with that startup and venture capitalist.
        FundingRound.new(startup, self, investment_type, investment_amount)
    end

    def funding_rounds
        # returns an array of all funding rounds for that venture capitalist
        FundingRound.all.select { |funding_round| funding_round.venture_capitalist == self }
    end
    
    def portfolio
        # Returns a unique list of all startups this venture capitalist has funded
        funding_rounds.map { |funding_round| funding_round.startup }.uniq
    end
    
    def biggest_investment
        # returns the largest funding round given by this venture capitalist
        
        # OPTION 1 (the hard way)
        # funding_rounds.max { |funding_round_1, funding_round_2| funding_round_1.investment <=> funding_round_2.investment }

        # OPTION 2 (the short way)
        funding_rounds.max_by { |funding_round| funding_round.investment }
    end
    
    def invested(domain)
        # given a domain string, returns the total amount invested in that domain
        
        # Get the FundingRounds associated with this VC that have the specified domain
        domain_funding_rounds = funding_rounds.select { |funding_round| funding_round.startup.domain == domain }

        # Sum the investment amount from each of the previous step's FundingRounds
        domain_funding_rounds.sum { |funding_round| funding_round.investment }
    end

    def self.all
        @@all
    end

    def self.tres_commas_club
        # Returns an array of all venture capitalists in the Trés Commas club (they have more then 1,000,000,000 total_worth)
        self.all.select { |vc| vc.in_tres_commas_club? }
    end

end
