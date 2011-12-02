require "assets_offline/version"

module AssetsOffline
  class Engine < Rails::Engine
  end if defined?(Rails) && Rails::VERSION::MAJOR == 3
end
