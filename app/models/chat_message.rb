class ChatMessage
  HISTORY = 20

  attr_accessor :message, :created_at

  def initialize(message, created_at=Time.now)
    @message = message
    @created_at = created_at
    self.class.push self
  end

  def self.push(chat_message)
    @chat_messages ||= []
    @chat_messages << chat_message
    @chat_messages = @chat_messages.reverse.take(HISTORY).reverse
  end

  def self.find
    @chat_messages ||= []
  end
end
