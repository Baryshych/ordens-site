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

  def find_similar
    token = token.present? ? token : create_token
    self.class.where(token: token).first
  end
end