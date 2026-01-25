module ApplicationHelper
  def render_attribute(model, attr, &block)
    attr_name = model.class.human_attribute_name(attr)
    value = block_given? ? capture(&block) : model[attr]

    content_tag(:p) do
      safe_join [
        content_tag(:strong, "#{attr_name}:"),
        value
      ], " "
    end
  end

  def time_ago_span(time)
    return unless time

    content_tag(:span, time_ago_in_words(time), title: time)
  end

  def voting_enabled?
    Rails.configuration.vote_url_template.present?
  end
end
