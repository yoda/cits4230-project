# This is the Compass configuration file. The configuration file for nanoc is 
# named “config.yaml”.

project_path = File.dirname(__FILE__)
http_path    = '/'
output_style = :expanded
sass_dir     = 'content/style'
css_dir      = 'output/style'
sass_options = {
  :debug_info => false,
  :line_comments => false
}