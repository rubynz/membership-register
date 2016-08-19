module ApplicationHelper
  def render_attribute(model, attr, &block)
    attr_name = model.class.human_attribute_name(attr)
    value = block_given? ? capture(&block) : model[attr]

    content_tag(:p) do
      safe_join [
        content_tag(:strong, "#{attr_name}:"),
        value,
      ], ' '
    end
  end
end
