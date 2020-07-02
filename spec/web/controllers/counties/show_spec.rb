RSpec.describe Web::Controllers::Counties::Show, type: :action do
  let(:action) { described_class.new }
  let(:params) { { name: 'Rankin' } }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
