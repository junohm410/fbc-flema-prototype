# frozen_string_literal: true

namespace 'discordbot' do
  desc 'sample bot'
  task ping: :environment do
    bot = Discordrb::Bot.new token: ENV['DISCORD_BOT_TOKEN']

    bot.message(with_text: 'Ping!') do |event|
      event.respond 'Pong!'
    end

    bot.run
  end
end
