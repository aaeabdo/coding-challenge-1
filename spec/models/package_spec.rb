require 'spec_helper'

RSpec.describe Package, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:version) }
    it { is_expected.to validate_presence_of(:publication_date) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:authors) }
    it { is_expected.to validate_presence_of(:maintainers) }
  end

  context "DB" do
    it "has columns" do
      is_expected.to have_db_column(:id).of_type(:uuid).with_options(primary: true, null: false)
      is_expected.to have_db_column(:name).of_type(:string).with_options(null: false)
      is_expected.to have_db_column(:version).of_type(:string).with_options(null: false)
      is_expected.to have_db_column(:publication_date).of_type(:datetime).with_options(null: false)
      is_expected.to have_db_column(:title).of_type(:string).with_options(null: false)
      is_expected.to have_db_column(:description).of_type(:text).with_options(null: false)
      is_expected.to have_db_column(:authors).of_type(:json).with_options(null: false)
      is_expected.to have_db_column(:maintainers).of_type(:json).with_options(null: false)
      is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false)
      is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false)

      expect(described_class.columns.length).to eq(10)
    end
  end
end
