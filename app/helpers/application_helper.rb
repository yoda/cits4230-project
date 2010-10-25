module ApplicationHelper
  
  def show_welcome_notice?
    cookies[:notice_hidden] != "1"
  end
  
  def ninja_errors(form, field, label = field.to_s.humanize)
    errors = Array(form.object.errors.on(field))
    if errors.present?
      message = "#{label} #{errors.to_sentence}.".gsub(/\.+$/, '.')
      content_tag :p, message, :class => 'field-errors', :style => 'display: block;'
    else
      content_tag :p, '', :class => 'field-errors'
    end
  end
  
  def linked_screenshot(story)
    image_url = "http://pinkyurl.com/i?url=#{URI.escape story.url}&out-format=png&resize=160&crop=160x140"
    inner = image_tag(image_url, :alt => story.title)
    link_to inner, story.url
  end
  
  def abstract_for(story)
    sanitize story.abstract.to_s.html_safe
  end
  
  def story_favourited_link(story)
    if current_user.has_favorite?(story)
      link_to "Remove from Favourites", favourite_site_story_path(story.site, story, "remove"), :class => 'story-favourite', :method => :post
    else
      link_to "Favourite Story", favourite_site_story_path(story.site, story, "add"), :class => 'story-favourite', :method => :post
    end
  end
  
  def story_liked_info(story)
    return unless user_signed_in?
    like = story.liked_by?(current_user)
    out = ActiveSupport::SafeBuffer.new
    like_path    = like_site_story_path(story.site, story, 'like')
    dislike_path = like_site_story_path(story.site, story, 'dislike')
    forget_path  = like_site_story_path(story.site, story, 'forget')
    if like
      liked = like.value > 0
      out << "You've already "
      out << (liked ? content_tag(:span, "liked", :class => 'story-up-vote') : content_tag(:span, "disliked", :class => 'story-down-vote'))
      out << " this story - "
      if liked
        out << link_to("Dislike it", dislike_path, :class => 'story-down-vote', :method => :post)
      else
        out << link_to("Like it", like_path, :class => 'story-up-vote', :method => :post)
      end
      out << " instead. "
      out << link_to('(forget)', forget_path, :class => 'story-forget-vote', :method => :post)
    else
      out << link_to("I Liked it", like_path, :class => 'story-up-vote', :method => :post)
      out << " or "
      out << link_to("I didn't like it", dislike_path, :class => 'story-down-vote', :method => :post)
    end
  end
  
  def page_title
    @page_title ||= nil
    h [@page_title, "Rubyocracy"].reject(&:blank?).join(" | ")
  end
  
end
