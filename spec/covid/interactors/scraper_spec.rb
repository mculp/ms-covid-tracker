RSpec.describe Scrape, type: :interactor do
  let(:interactor) { Scrape.new('./spec/support/COVID/6-25/index.htm') }

  it "succeeds" do
    result = interactor.call
    expect(result.successful?).to be(true)
    expect(CountyRepository.new.all.count).to eq 82
    expect(CountyUpdateRepository.new.all.count).to eq 82
  end

  it "parses 83 counties" do
    expect(interactor.send(:counties).size).to eq 82
  end
end
