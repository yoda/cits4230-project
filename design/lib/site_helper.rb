module SiteHelper
  
  def pending_link(title, url = '#', opts = {})
    link_to title, url, opts.merge(:onclick => "alert('This page is not yet implemented.'); return false;")
  end
  
  def quote
    quotes = [
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin posuere arcu non erat tincidunt sed molestie turpis accumsan. Proin id ultricies ligula. Vivamus nec enim risus, a pretium mi. Nulla at cursus eros. Fusce congue mauris quis augue rhoncus et tempus enim hendrerit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Morbi ullamcorper tempor posuere. Proin molestie faucibus nibh ac auctor. Nulla ut dui in eros sodales rhoncus.",
      "Aliquam pretium vulputate sem sit amet fringilla. Nulla auctor sem ut libero viverra imperdiet. Pellentesque ultricies metus sed risus ullamcorper tempus. Integer blandit, ante eu tempus luctus, neque mi suscipit sapien, vitae volutpat tellus augue a libero. Curabitur ut nisl leo. Aenean ullamcorper consectetur consequat. Fusce non sollicitudin tellus. Quisque facilisis faucibus arcu, nec dignissim sapien laoreet commodo. Nulla nibh urna, pellentesque vel venenatis non, gravida ac nisi. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      "Fusce sodales neque ut metus consequat sed varius mauris facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus venenatis auctor bibendum. Donec venenatis convallis rutrum. Nam laoreet, ipsum vitae consequat dapibus, leo justo rutrum eros, ut viverra lacus velit sit amet turpis. Vestibulum libero augue, pulvinar sed tempor at, imperdiet eget felis. Ut dui velit, pellentesque ac bibendum ut, auctor a risus. Vivamus mi erat, posuere quis lobortis hendrerit, tempor ac erat.",
      "Maecenas euismod dui sit amet ante ultricies id posuere urna pellentesque. Sed lectus purus, laoreet nec lobortis a, tempus a arcu. Donec convallis fringilla lectus. Maecenas et arcu lorem, viverra varius massa. Fusce placerat massa varius risus tempor sed dapibus odio egestas. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Quisque fermentum accumsan leo, mattis varius neque tempus ut."
    ]
    quotes[rand(quotes.length)]
  end
  
  def screenshot(url, height = 160, width = 140)
    "http://pinkyurl.com/i?url=#{URI.escape(url)}&out-format=png&resize=#{height}&crop=#{height}x#{width}"
  end
  
end
include SiteHelper