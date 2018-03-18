# frozen_string_literal: true

RSpec.describe Types do
  let(:repo) { described_class.new }

  describe 'AccountRoles' do
    subject { Types::AccountRoles }

    it { expect { subject['other'] }.to raise_error(Dry::Types::ConstraintError) }
    it { expect { subject[nil] }.to raise_error(Dry::Types::ConstraintError) }
    it { expect { subject[:regular] }.to raise_error(Dry::Types::ConstraintError) }

    it { expect { subject[:regular] }.to raise_error(Dry::Types::ConstraintError) }

    %w[regular advanced admin].each_with_index do |role, index|
      it { expect(subject[index]).to eq role }
      it { expect(subject[role]).to eq role }

      it { expect { subject[role.to_sym] }.to raise_error(Dry::Types::ConstraintError) }
    end
  end
end
