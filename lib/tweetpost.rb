require 'twitter'

class Tweetpost
  def build(token, secret, tweets)
    binding.pry
    client = get_twitter_client(token, secret)
    binding.pry
    update(client, tweets)
  end

  private
  def get_twitter_client(token, secret)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = 'Wq0oK8SkbQnCMkFGFPddmp7mZ'
      config.consumer_secret     = 'aqAQDCbMrGh8iXCErpx3BdiJ5IjMyQO0TR1drbXQpK12wc8IXB'
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
end
