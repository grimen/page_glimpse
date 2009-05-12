require 'rubygems'

gem 'httparty', '0.4.3'
require 'httparty'


# 'http://images.pageglimpse.com/v1/thumbnails/request?url=http://google.com&size=medium&devkey=ec0ccd30be1b39393d19cb5f410d26df'
# 'http://images.pageglimpse.com/v1/thumbnails/exists?url=http://google.com&size=medium&devkey=ec0ccd30be1b39393d19cb5f410d26df'
# 'http://images.pageglimpse.com/v1/thumbnails?url=http://google.com&size=medium&devkey=ec0ccd30be1b39393d19cb5f410d26df'

class PageGlimse
  
  InvalidAPIKeyError = Class.new(StandardError)
  
  include HTTParty
  
  PG_API_URL = 'http://images.pageglimpse.com/v1'.freeze
  PG_VALID_SIZE_VALUES = [:small, :medium, :large].freeze
  PG_VALID_ROOT_VALUES = [:yes, :no].freeze
  PG_IMAGE_FORMAT = :png
  
  ACTION_PARAMS = {
      :thumbnails => [:devkey, :url, :size, :root, :nothumb],
      :'thumbnails/exists' => [:devkey, :url, :size],
      :'thumbnails/request' => [:devkey, :url]
    }.freeze
    
  DEFAULT_OPTIONS = {
      :size => :medium,
      :root => true,
      :nothumb => nil
    }.freeze
    
  base_uri(PG_API_URL)
  
  attr_accessor :defaults,
                :devkey,
                :url,
                :size,
                :root,
                :nothumb
                
  def initialize(devkey, defaults = {})
    @defaults = DEFAULT_OPTIONS.merge(defaults)
    @devkey = devkey
  end
  
  def thumbnail(url, options = {})
    options = defaults.merge(options)
    @url = url
    @size = valid_size_value(options[:size])
    @root = valid_root_value(options[:root])
    @nothumb = options[:nothumb]
    
    query_url = generate_url('thumbnails')
    response = self.class.get(query_url)
    handle_response(response)
    response.body
  end
  alias :thumbnails :thumbnail
  
  def save!(url, path, options = {})
    begin
      data = thumbnail(url, options)
      path = File.join(path, "#{url.gsub(/(http:)|[\/]/, '')}.#{PG_IMAGE_FORMAT}") if File.directory?(path)
      File.new(path, 'w')
      File.open(path, 'w') { |f| f.write(data) }
    rescue
      false
    else
      true
    end
  end
  
  def request!(url, options = {})
    options = defaults.merge(options)
    @url = url
    
    query_url = generate_url('thumbnails', 'request')
    response = self.class.get(query_url)
    handle_response(response.code)
  end
  
  def exists?(url, options = {})
    options = defaults.merge(options)
    @url = url
    @size = valid_size_value(options[:size])
    
    query_url = generate_url('thumbnails', 'exists')
    response = self.class.get(query_url)
    handle_response(response.code)
  end
  alias :exist? :exists?
  
  private
  
  def handle_response(response_code)
    case response_code.to_i
    when 200 then
      true
    when 404 then
      false
    when 403 then
      raise InvalidAPIKeyError, "Error: Invalid PageGlimse API key."
    end
  end
  
  def valid_root_value(root)
    root ||= true
    (root == true) ? :yes : :no
  end
  
  def valid_size_value(size)
    PG_VALID_SIZE_VALUES.include?(size.to_sym) ? size : :medium
  end
  
  def generate_url(*args)
    action = args.join('/').to_sym
    params = []
    params << "url=#{@url}" if ACTION_PARAMS[action].include?(:url)
    params << "size=#{@size}" if ACTION_PARAMS[action].include?(:size)
    params << "root=#{@root}" if ACTION_PARAMS[action].include?(:thumbnail)
    params << "nothumb=#{@nothumb}" if ACTION_PARAMS[action].include?(:nothumb) && @nothumb && !@nothumb.empty?
    params << "devkey=#{@devkey}" if ACTION_PARAMS[action].include?(:devkey)
    "/#{action}?#{params.join('&')}"
  end
  
end