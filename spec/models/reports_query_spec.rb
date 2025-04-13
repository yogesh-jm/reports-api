require 'rails_helper'

RSpec.describe ReportsQuery do
  describe "#call" do
    before do
      # Create 25 reports for pagination testing
      25.times do |i|
        Report.create!(
          title: "Report #{i + 1}",
          description: "Description #{i + 1}",
          reporter: "Reporter #{i + 1}"
        )
      end
    end

    context "with valid pagination params" do
      let(:params) { { page: 2, per_page: 10 } }

      it "returns correct page of reports" do
        result = described_class.new(params).call

        expect(result[:reports].size).to eq(10)
        expect(result[:meta][:current_page]).to eq(2)
        expect(result[:meta][:per_page]).to eq(10)
        expect(result[:meta][:total_count]).to eq(25)
        expect(result[:meta][:total_pages]).to eq(3)

        expect(result[:reports].first.title).to eq("Report 11")
      end
    end

    context "with default pagination" do
      let(:params) { {} }

      it "uses default pagination values" do
        result = described_class.new(params).call

        expect(result[:reports].size).to eq(10) # default per_page
        expect(result[:meta][:current_page]).to eq(1)
        expect(result[:meta][:per_page]).to eq(10)
      end
    end

    context "with invalid pagination values" do
      let(:params) { { page: -1, per_page: 0 } }

      it "falls back to defaults" do
        result = described_class.new(params).call

        expect(result[:meta][:current_page]).to eq(1)
        expect(result[:meta][:per_page]).to eq(10)
      end
    end

    context "with per_page greater than total records" do
      let(:params) { { page: 1, per_page: 100 } }

      it "returns all available records" do
        result = described_class.new(params).call

        expect(result[:reports].size).to eq(25)
        expect(result[:meta][:total_pages]).to eq(1)
      end
    end
  end
end
