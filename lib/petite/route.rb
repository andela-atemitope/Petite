module Petite
  class Router
    attr_reader :routes
    def initialize
      @routes = Hash.new { |hash, key| hash[key] = [] }
    end

    def self.match(*verbs)
      verbs.each do |verb|
        define_method(verb) do |path, option = {}|
          url_parts = path.split("/")
          url_parts.select! { |part| !part.empty? }
          placeholders = []
          regexp_parts = url_parts.map do |part|
            get_placeholder(placeholders, part)
          end
          gather_routes(verb, regexp_parts, placeholders, option)
        end
      end
    end

    match :get, :post, :put, :patch, :delete

    def gather_routes(verb, regexp_parts, placeholders, option)
      regexp = regexp_parts.join("/")
      routes[verb] << [Regexp.new("^/#{regexp}$"),
                       parse_to(option[:to]), placeholders]
    end

    def get_placeholder(placeholders, part)
      if part[0] == ":"
        placeholders << part[1..-1]
        "([A-Za-z0-9_]+)"
      else
        part
      end
    end

    def draw(&block)
      instance_eval(&block)
    end

    def check_url(request)
      url = request.path_info
      verb = request.request_method.downcase.to_sym
      match_path = routes[verb].detect do |route|
        route.first.match(url)
      end
      find_match(match_path, url, request)
    end

    def find_match(match_path, url, request)
      if match_path
        placeholder = {}
        match = match_path.first.match(url)
        held_value = match_path[2]
        held_value.each_with_index do |value, index|
          placeholder[value] = match.captures[index]
        end
        request.params.merge!(placeholder)
        match_path << placeholder
        controller_name = match_path[1][:controller].to_camel_case
        controller = Object.const_missing("#{controller_name}Controller")
        controller.action(request, match_path[1][:action])
      end
    end

    private

    def parse_to(option)
      controller, action = option.split('#')
      { controller: controller.to_camel_case, action: action }
    end
  end
end
