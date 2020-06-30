RSpec.describe CountyRepository, type: :repository do
  let(:repository) { CountyRepository.new }

  it "finds a county by name" do
    repository.create(name: 'Rankin')
    expect(repository.find_by_name('Rankin')).to be
  end

  it "finds or creates a county by name" do
    repository.find_or_create_by_name('TestCounty')
    expect(repository.find_or_create_by_name('TestCounty').name).to eq 'TestCounty'
  end
end
