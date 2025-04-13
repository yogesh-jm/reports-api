class ReportsQuery
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10

    reports = base_query.offset((page - 1) * per_page).limit(per_page)

    {
      reports: reports,
      meta: {
        current_page: page,
        per_page: per_page,
        total_count: total_count,
        total_pages: (total_count.to_f / per_page).ceil
      }
    }
  end

  private

  def base_query
    Report.order(:id)
  end

  def total_count
    @_total_count ||= base_query.count
  end
end
