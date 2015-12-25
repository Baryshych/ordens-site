class Report
  def self.all
    YAML.load_file('config/reports.yml')  
  end

  def initialize(report_id)
    @report = self.class.all.find { |x| x['id'] == report_id.to_i }
  end

  def generate(profiles)
    processed, file_path = generate_report(profiles)
    categories = AwardCategory.all.map { |x| [x.id, x.title] }.to_h
    result = []
    processed.each do |p|
      result << {
        full_name: p.full_name,
        award_title: p.last_award.award_type.try(:title),
        category: categories[p.last_award.award_type.award_category_id],
        status: p.last_award.status,
        success: p.error.blank?,
        error: p.error
      }
    end
    [result, file_path]
  end

  def generate_report(profiles)
    filtered = FilterService.new(@report['filters']).filter(profiles)
    data_generator = @report['data_generator'].constantize
    file_generator = @report['file_generator'].constantize
    data = data_generator.new.generate(filtered)
    file_path = file_generator.new(@report['source']).generate(data)
    [filtered, file_path]
  end
end
