module CommonPagesHelper
  def page_title(name = '')
    site_config = Rails.configuration.x.site
    if name.empty?
      site_config[:base_title]
    else
      site_config[:base_title]
    end
  end
end
