RSpec.describe Scrape, type: :interactor do
  let(:interactor) { Scrape.new(File.read('./spec/support/COVID/6-27/index.htm')) }

  it "succeeds" do
    result = interactor.call
    expect(result.successful?).to be(true)
    expect(CountyRepository.new.all.count).to eq 82
    expect(CountyUpdateRepository.new.all.count).to eq 82
  end

  it "finds the date" do
    expect(interactor.date.month).to eq 6
    expect(interactor.date.day).to eq 27
    expect(interactor.date.year).to eq 2020
  end

  it "parses 82 counties" do
    expect(interactor.counties.size).to eq 82
  end

  it "sets previous_update_id for subsequent runs" do
    second_interactor = Scrape.new(File.read('./spec/support/COVID/6-28/index.htm'))

    first_results = interactor.call
    second_results = second_interactor.call

    expect(second_results.county_updates.first.previous_update_id)
      .to eq first_results.county_updates.first.id
  end
end
