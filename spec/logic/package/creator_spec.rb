require 'spec_helper'
require_relative '../../../logic/package/creator'

RSpec.describe Logic::Package::Creator do
  subject(:call) { described_class.call(model, creation_params) }
  let(:model)    { class_double('Package') }
  let(:creation_params) do
    {
      name:             "ABC.RAP",
      version:          "0.9.0",
      publication_date: '2016-10-20 10:52:16',
      title:            "Array Based CpG Region Analysis Pipeline",
      description:      "It aims to identify candidate genes that are “differentially methylated”",
      authors:
        [
          {
            name:  "Abdulmonem Alsaleh",
            email: nil,
            roles: ["cre", "aut"]
          }
        ],
      maintainers:[
        {
          name:  "Abdulmonem Alsaleh",
          email: "a.alsaleh@hotmail.co.nz",
          roles: ["cre"]
        }
      ]
    }
  end

  context '.call' do
    let(:package) { instance_double('Package') }
    let(:initialization_params) do
      creation_params.slice(:name, :version)
    end

    it 'runs successfully' do
      expect(model)
        .to receive(:find_or_initialize_by)
        .with(initialization_params)
        .and_return(package)
      expect(package)
        .to receive(:assign_attributes)
        .with(creation_params)
      expect(package)
        .to receive(:save!)

      call
    end
  end
end
