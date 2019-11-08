if ENV['DD_AGENT_HOST']
  Datadog.configure do |c|
    c.use :rails
  end
end