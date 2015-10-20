module Tokenable
  extend ActiveSupport::Concern

  included do
    after_validation :create_token
  end

  def create_token
    stemmer = Stemmer.new
    corrector = ReplacedSymbolsCorrector.new
    source = self.respond_to?(:description) ? description : title
    self.token = source.mb_chars.downcase.to_s
                       .tr('^[а-яєїэъіґa-z]', ' ')
                       .split(' ')
                       .map{ |w| stemmer.stem(corrector.correct(w)) }
                       .sort.join(' ')
  end
end