class NoHtmlValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)
    unless value == ActionController::Base.helpers.strip_tags(value)
      object.errors[attribute] << (options[:message] || I18n.t('errors.messages.unwanted_html_tags'))
    end
  end

end
