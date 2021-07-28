require_relative 'view'
module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      view = View.new(@request.env)
      return @request.env['simpler.template'] unless view.path_exist?

      view.render(binding)
    end

    def params
      @request.params
    end

    def render(template)
      method, path = template.first
      @request.env['simpler.method'] = method || 'html'
      @request.env['simpler.template'] = path || template
    end

    def status(code)
      @response.status = code
    end

    def headers
      @response.headers
    end
  end
end
