class ReplacedSymbolsCorrector
  def bunch_correct(words)
    words.map do |word|
      { word: correct(word['word']), start: word['start'], length: word['length'] }
    end
  end

  def correct(word)
    @word = word
    @word_lowercase = word.mb_chars.downcase.to_s
    if replaces_detected?
      alphabet = detect_alphabet
      correct_to(alphabet)
    else
      @word
    end
  end

  def replaces_detected?
    /[a-z][а-яєїэъ]|[а-яєїэъ][a-z]/ =~ @word_lowercase
  end

  def detect_alphabet
    if /[йцгшщзъфыплджэячьбюїмєґ]/ =~ @word_lowercase
      :cyrillic
    elsif /[qwrtsdfghjlzvb]/ =~ @word_lowercase
      :latin
    else
      :cyrillic
    end
  end

  def correct_to(alphabet)
    alphabet_map = alphabet == :cyrillic ? @@latin_to_cyrillic_map : @@cyrillic_to_latin_map
    @word.mb_chars.each_char.map do |letter|
      if alphabet_map.keys.include? letter
        alphabet_map[letter]
      else
        letter
      end
    end.join('')
  end

  @@latin_to_cyrillic_map = 
    { 'A' => 'А',
      'B' => 'В',
      'C' => 'С',
      'E' => 'Е',
      'H' => 'Н',
      'I' => 'І',
      'K' => 'К',
      'M' => 'М',
      'O' => 'О',
      'P' => 'Р',
      'X' => 'Х',
      'Y' => 'У',
      'a' => 'а',
      'c' => 'с',
      'e' => 'е',
      'i' => 'і',
      'k' => 'к',
      'o' => 'о',
      'p' => 'р',
      'u' => 'и',
      'w' => 'ш',
      'x' => 'х',
      'y' => 'у' }

  @@cyrillic_to_latin_map = 
    { 'А' => 'A',
      'В' => 'B',
      'С' => 'C',
      'Е' => 'E',
      'Н' => 'H',
      'І' => 'I',
      'К' => 'K',
      'М' => 'M',
      'О' => 'O',
      'Р' => 'P',
      'Х' => 'X',
      'У' => 'Y',
      'а' => 'a',
      'с' => 'c',
      'е' => 'e',
      'і' => 'i',
      'к' => 'k',
      'о' => 'o',
      'р' => 'p',
      'и' => 'u',
      'ш' => 'w',
      'х' => 'x',
      'у' => 'y'  }
end