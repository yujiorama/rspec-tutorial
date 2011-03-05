class MessageFilter
  def initialize *words
    @ng_words = words
    @ignore_case = false
  end
  
  attr_reader :ng_words
  attr_accessor :ignore_case
  
  def detect? text
    if @ignore_case
      @ng_words.any? {|w| text.downcase.include? w.downcase}
    else
      @ng_words.any? {|w| text.include? w}
    end
  end
end

