module SiteHelper
  
  def pending_link(title, url = '#')
    link_to title, url, :onclick => "alert('This page is not yet implemented.'); return false;"
  end
  
end
include SiteHelper