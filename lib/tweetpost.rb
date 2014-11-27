require 'twitter'

class Tweetpost
  def build(token, secret, tweets, image='no_image')
    client = get_twitter_client(token, secret)
     if image.eql?('no_image')
       update(client, tweets)
     else
       update(client, tweets, image)
     end
  end

  private
  def get_twitter_client(token, secret)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = token
      config.access_token_secret = secret
    end
    client
  end

  def update(client, tweet)
    begin
      tweet = (tweet.length > 140) ? tweet[0..139].to_s : tweet
      client.update(tweet.chomp)
    rescue => e
      Rails.logger.error "<<twitter.rake::tweet.update ERROR : #{e.message}>>"
    end
  end

  def update(client, tweet, image)
    begin
      tweet = (tweet.length > 140) ? tweet[0..139].to_s : tweet
      client.update_with_media(tweet.chomp, image)
    rescue => e
      Rails.logger.error "<<twitter.rake::tweet.update ERROR : #{e.message}>>"
    end
  end
end
