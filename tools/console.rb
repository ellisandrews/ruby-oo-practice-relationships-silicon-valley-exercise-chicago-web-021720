require_relative '../config/environment.rb'

def reload
  load 'config/environment.rb'
end
# Insert code here to run before hitting the binding.pry
# This is a convenient place to define variables and/or set up new object instances,
# so they will be available to test and play around with in your console

# Create some Startups
apple = Startup.new('Apple', 'Steve Jobs', 'Technology')
microsoft = Startup.new('Microsoft', 'Bill Gates', 'Technology')
amazon = Startup.new('Amazon', 'Jeff Bezos', 'eCommerce')

# Create some VentureCapitalists
vc_1 = VentureCapitalist.new('VC 1', 10**6)
vc_2 = VentureCapitalist.new('VC 2', 10**10)

# Create some FundingRounds
fr_1 = FundingRound.new(apple, vc_1, 'Series A', 500000)
apple.sign_contract(vc_1, 'Series B', 1000000)
fr_3 = FundingRound.new(microsoft, vc_2, 'Series C', 900000)
amazon.sign_contract(vc_1, 'Series D', 110000)


binding.pry
0 #leave this here to ensure binding.pry isn't the last line