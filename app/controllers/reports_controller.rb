class ReportsController < ApplicationController

  def create
    id = Zlib::crc32(params[:profiles].sort.join + params[:report_id].to_s)
    session[id] = { profiles: params[:profiles], report_id: params[:report_id] }
    render json: { id: id }
  end

  def index
    id = params[:id]
    profiles = Profile.where(id: session[id]['profiles']).includes(:awards)
    result, file = Report.new(session[id]['report_id']).generate(profiles)
    render json: result, root: 'reports',
           meta: { file: file }
  end
end
