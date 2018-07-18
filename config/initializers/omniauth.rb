OmniAuth.config.logger = Rails.logger
OmniAuth.config.logger = Logger.new(STDOUT)
OmniAuth.logger.progname = "omniauth"
  
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '102575190301783', 'baa735f84b80894a54d877d69828cdb1'
end 

