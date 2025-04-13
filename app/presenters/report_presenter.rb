# app/presenters/report_presenter.rb
class ReportPresenter
    def initialize(report)
      @report = report
    end

    def as_json(*)
      {
        id: @report.id,
        title: @report.title,
        description: @report.description,
        reporter: @report.reporter,
        created_at: @report.created_at.strftime("%Y-%m-%d")
      }
    end
end
