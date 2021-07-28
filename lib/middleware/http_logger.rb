require 'logger'

class HttpLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:log_path] || $stdout)
    @app = app
  end

  def call(env)
    response = @app.call(env)

    log_request(env)
    log_handler(env)
    log_response(env, response)

    response
  end

  private

  def log_request(env)
    method = env['REQUEST_METHOD']
    uri = env['REQUEST_URI']

    @logger.info("Request: #{method} #{uri}")
  end

  def log_handler(env)
    controller = env['simpler.controller']
    action = env['simpler.action']

    if controller
      @logger.info("Handler: #{controller.class.name}##{action}")
      @logger.info("Parameters: #{controller.send(:params)}")
    else
      @logger.info('Controller not found')
    end
  end

  def log_response(env, response)
    status, headers, body = response
    template = env['simpler.template_path']
    @logger.info("Response: #{status} [#{headers['Content-Type']}] #{template}")
  end
end
