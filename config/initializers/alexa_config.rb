# Load Alexa configurations from config/alexa.yml
#
ALEXA_CONFIG = YAML.load_file(Rails.root.join('config/alexa.yml'))[Rails.env]
