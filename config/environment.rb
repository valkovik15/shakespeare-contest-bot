# Load the Rails application.
require_relative 'application'
require 'net/http'

# Initialize the Rails application.
Rails.application.initialize!
logger = Logger.new logfile.log
Logger.level = Logger::WARN

# logs for program called MainProgram
logger.progname = 'MainProgram'

# a simple formatter
logger.formatter = proc do |severity, time, progname, msg|
  "#{datetime}: #{msg} from #{progname} \n"
end

logger.info("Some error.")