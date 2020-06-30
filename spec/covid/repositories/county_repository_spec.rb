RSpec.describe CountyRepository, type: :repository do
  let(:repository) { CountyRepository.new }

  before(:all) { CountyRepository.new.create(name: 'Rankin') }

  it "finds a county by name" do
    expect(repository.find_by_name('Rankin')).to be
  end

  it "finds or creates a county by name" do
    repository.find_or_create_by_name('TestCounty')
    expect(repository.find_or_create_by_name('TestCounty').name).to eq 'TestCounty'
  end
end
