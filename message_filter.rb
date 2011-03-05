class MessageFilter
  def initialize *words
    @ng_words = words
    @ignore_case = false
  end
  
  attr_reader :ng_words
  attr_accessor :ignore_case
  
  def detect? text
    @ng_words.any? {|w| text.downcase.include? w.downcase}
  end
end

