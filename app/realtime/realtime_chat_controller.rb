class RealtimeChatController < FayeRails::Controller
  channel '/chat' do
    subscribe do
      Rails.logger.debug "Received on #{channel}: #{inspect}"

      created_at = if message['created_at'] && message['created_at'].size > 0
                     Time.parse(message['created_at'])
                   else
                     Time.now
                   end

      ChatMessage.new(message['message'], created_at)
    end
  end
end
