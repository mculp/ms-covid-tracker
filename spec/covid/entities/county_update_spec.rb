RSpec.describe CountyUpdate, type: :entity do
  let(:subject) {
    CountyUpdate.new(
      cases: 8,
      previous_update: CountyUpdate.new(
        cases: 6
      )
    )
  }

  it "calculates percent change in new cases" do
    expect(subject.new_cases_percent_change).to eq 33
  end
end
