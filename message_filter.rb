class MessageFilter
  def initialize *words
    @ng_words = words
    @ignore_case = false
  end
  
  attr_reader :ng_words
  attr_accessor :ignore_case
  
  def detect? text
    t = (@ignore_case ? text.downcase : text)
    @ng_words.any? {|w| t.include? (@ignore_case ? w.downcase : w)}
  end

end

