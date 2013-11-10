module ApplicationHelper
  def hash(h)
    content_tag :span, h[0...12], class: "hash", title: h
  end

  def time_ago(t)
    content_tag :span, distance_of_time_in_words_to_now(t) + " ago", class: "time_ago", title: t
  end

  def gravatar(email)
    "https://gravatar.com/avatar/#{Digest::MD5.hexdigest(email.strip.downcase)}"
  end
end
