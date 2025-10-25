class ApplicationController < ActionController::Base
  before_action :set_locale
  allow_browser versions: :modern

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_locale
    locale = params[:locale] || I18n.default_locale

    I18n.locale = I18n.available_locales.map(&:to_s).include?(locale.to_s) ? locale : I18n.default_locale
  end
end
