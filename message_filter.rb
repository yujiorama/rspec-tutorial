class MessageFilter
  def initialize *words
    @words = words
  end
  
  def detect? text
    @words.each do |word|
      return true if text.include?(word)
    end
    false
  end
end
