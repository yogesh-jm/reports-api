require 'rails_helper'

RSpec.describe "Reports API", type: :request do
  let!(:reports) { create_list(:report, 3) }
  let(:report_id) { reports.first.id }

  describe "GET /reports" do
    context "when reports are present" do
      it "returns a list of reports with metadata" do
        get "/reports"

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)

        # binding.pry
        expect(body["data"].size).to eq(3)
        expect(body["meta"]).to be_present
      end
    end

    context "when no reports are present" do
      before { Report.delete_all }

      it "returns not_found with error message" do
        get "/reports"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("No reports found")
      end
    end
  end

  describe "GET /reports/:id" do
    it "returns the report if found" do
      get "/reports/#{report_id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(report_id)
    end

    it "returns not_found if report doesn't exist" do
      get "/reports/999999"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Report not found")
    end
  end

  describe "POST /reports" do
    let(:valid_attributes) { { report: { title: "Test", description: "Some text", reporter: "Yogesh" } } }

    it "creates a report" do
      expect {
        post "/reports", params: valid_attributes
      }.to change(Report, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["title"]).to eq("Test")
      expect(JSON.parse(response.body)["reporter"]).to eq("Yogesh")
    end

    it "returns validation errors if required fields are missing" do
      post "/reports", params: { report: { title: "", reporter: "" } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["errors"]).to include("Title can't be blank", "Reporter can't be blank")
    end
  end

  describe "PUT /reports/:id" do
    let(:update_params) { { report: { title: "Updated title XYZ" } } }

    it "updates the report" do
      put "/reports/#{report_id}", params: update_params

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["title"]).to eq("Updated title XYZ")
    end

    it "returns error for non-existent report" do
      put "/reports/999999", params: update_params

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Report not found")
    end
  end

  describe "DELETE /reports/:id" do
    it "deletes the report" do
      expect {
        delete "/reports/#{report_id}"
      }.to change(Report, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "returns error if report not found" do
      delete "/reports/999999"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Report not found")
    end
  end
end
