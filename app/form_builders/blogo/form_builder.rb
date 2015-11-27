class Blogo::FormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Context
  include ActionView::Helpers::TagHelper

  def error_messages
    return if object.errors.empty?

    content_tag(:div, class: "alert alert-error") do
      content_tag(:ul) do
        object.errors.full_messages.map do |msg|
          content_tag(:li, msg)
        end.join.html_safe
      end
    end
  end
end
