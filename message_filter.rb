class MessageFilter
  def initialize *words
    @ng_words = words
    @ignore_case = false
  end
  
  attr_reader :ng_words
  attr_accessor :ignore_case
  
  def detect? text
    t = text.downcase if @ignore_case
    @ng_words.any? {|w| text.include? (@ignore_case ? w : w.downcase)}
  end
end

