require_relative 'time_formatter'

class App

  def call(env)
    @env = env
    time_path? ? handle_params : response(404, 'Not Found')
  end

  private

  def time_path?
    @env['PATH_INFO'] == '/time'
  end

  def response(status, body)
    Rack::Response.new(
      "#{body}\n",
      status,
      { 'Content-Type' => 'text/plain' }
    ).finish
  end

  def handle_params
    formatter = TimeFormatter.new(params['format'])
    
    if params['format'] && params['format'] != ''
      formatter.call
      formatter.valid? ? response(200, formatter.time) : response(400, formatter.unknown_formats)
    else
      response(200, '')
    end
  end

    def params
      Rack::Utils.parse_nested_query(@env['QUERY_STRING'])
    end

  end
