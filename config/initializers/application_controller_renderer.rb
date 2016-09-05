# Be sure to restart your server when you modify this file.

# ApplicationController.renderer.defaults.merge!(
#   http_host: 'example.org',
#   https: false
# )

ActionController::Renderers.add :csv do |obj, options|
  disposition = 'attachment'
  disposition += "; filename=#{options[:filename]}.csv" if options[:filename]

  str = obj.respond_to?(:to_csv) ? obj.to_csv : obj.to_s
  send_data str, type: Mime[:csv], disposition: disposition
end
