require 'kinja'

module Updater
  def self.client
    Kinja::Client.new(
      user: ENV["KINJA_USER"],
      password: ENV["KINJA_PASS"]
    )

  end

  def self.run(url, blog_id)
    now = DateTime.now + 1.second
    timestamp = now.strftime('%Q').to_i
    puts "Updating #{url}..."
    result = client.update_post(url, {
      publishTimeMillis: timestamp,
      defaultBlogId: blog_id
    })
    puts result
  end

  def self.should_update?(date=DateTime.now)
    is_weekday?(date) or is_morning?(date)
  end

  def self.is_weekday?(date=DateTime.now)
    date.strftime('%u').to_i < 6
  end

  def self.is_morning?(date=DateTime.now)
    date.strftime('%k').to_i < 15
  end

  def self.time_to_update(now, update_time)
    true
  end
end
