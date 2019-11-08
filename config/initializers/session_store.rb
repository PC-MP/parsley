Rails.application.config.session_store(
  :cache_store,
  {
    cache:        ActiveSupport::Cache.lookup_store(
                    :redis_cache_store,
                    {
                      url:           ENV['REDIS_URL'],  
                      error_handler: -> (method:, returning:, exception:) {
                        Raven.capture_exception(
                          exception,
                          level: 'warning',
                          tags:  { method: method, returning: returning }
                        )
                      }
                    }
                  ),
    expire_after: 24 * 60 * 60,
    secure:       Rails.env.production?
  }
)