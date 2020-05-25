class TimeFormatter

  TIME_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S',
  }.freeze

  attr_reader :received_formats

  def initialize(format, time = Time.now)
    @received_formats = format.split(',')
    @time = time
  end
  
  def call
    @unknown_formats = @received_formats - TIME_FORMATS.keys
  end

  def time 
    template = @received_formats.map { |format| TIME_FORMATS[format] }.join('-')
    @time.strftime(template)
  end

  def unknown_formats
    "Unknown time format [#{@unknown_formats.join(',')}]"
  end

  def valid?
    @unknown_formats.empty?
  end

end

