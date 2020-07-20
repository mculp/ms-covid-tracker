RSpec.describe Scrape, type: :interactor do
  let(:interactor) { Scrape.new(File.read('./spec/support/COVID/6-27/index.htm')) }

  before(:each) {
    interactor = Scrape.new(File.read('./spec/support/COVID/6-27/index.htm'))
    interactor.counties.each do |county|
      CountyRepository.new.create(name: county)
    end
  }

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

  it "parses rows without LTC data" do
    interactor = Scrape.new(File.read('./spec/support/COVID/7-5/index.htm'))

    expect(interactor.rows.first.values).to eq([["311", "18"]])
  end

  it "checks for LTC data" do
    interactor = Scrape.new(File.read('./spec/support/COVID/7-5/index.htm'))
    expect(interactor.without_ltc_data?).to be
  end
end
