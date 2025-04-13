class ReportsController < ApplicationController
    before_action :ensure_report_presence!, only: %i[show update destroy]

  def index
    result = ReportsQuery.new(params).call

    if result[:reports].any?
        render json: {
            data: result[:reports].map { |report| ::ReportPresenter.new(report).as_json },
            meta: result[:meta]
          }, status: :ok
    else
      render json: { error: "No reports found"  }, status: :not_found
    end
  end

  def show
    if report
      render json: report, status: :ok
    else
      render json: { error:  "Report not found" }, status: :not_found
    end
  end

  def create
    report = Report.new(report_params)

    if report.save
      render json: report, status: :created
    else
      render json: { errors: report.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if report.update!(report_params)
      render json: report, status: :ok
    else
      render json: { errors: report.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    report.destroy!
    render json: { message: "Report successfully deleted" }, status: :no_content
  end

  private

  def ensure_report_presence!
    unless report
     render json: { error: "Report not found" }, status: :not_found
     nil
    end
  end

  def report
    @_report ||= Report.find_by(id: params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :description, :reporter)
  end
end
