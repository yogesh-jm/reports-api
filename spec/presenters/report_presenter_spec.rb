require 'rails_helper'

RSpec.describe ReportPresenter, type: :presenter do
  let(:report) do
    Report.new(
      id: 1,
      title: "Report XYZ",
      description: "This is a test report.",
      reporter: "Yogesh",
      created_at: DateTime.new(2025, 4, 12)
    )
  end

  subject { described_class.new(report) }

  describe "#as_json" do
    it "returns the expected JSON representation" do
      expect(subject.as_json).to eq(
        {
          id: 1,
          title: "Report XYZ",
          description: "This is a test report.",
          reporter: "Yogesh",
          created_at: "2025-04-12"
        }
      )
    end
  end
end
