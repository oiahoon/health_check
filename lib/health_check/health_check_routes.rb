module ActionDispatch::Routing
  class Mapper

    def health_check_routes(prefix = nil)
      HealthCheck::Engine.routes_explicitly_defined = true
      add_health_check_routes(prefix)
    end

    def add_health_check_routes(prefix = nil)
      HealthCheck.uri = prefix if prefix
      match "#{HealthCheck.uri}(/status)(.:format)", :to => 'health_check/health_check#status', via: [:get, :post], :defaults => { :format => 'json' }
      match "#{HealthCheck.uri}(/:checks)(.:format)", :to => 'health_check/health_check#index', via: [:get, :post], :defaults => { :format => 'json' }
    end

  end
end
