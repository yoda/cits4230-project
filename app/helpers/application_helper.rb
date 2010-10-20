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
  
end
