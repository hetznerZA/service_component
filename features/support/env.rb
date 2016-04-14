require './features/support/requires'

Requires::require_files

Before do |scenario|
  begin
    feature = scenario.feature.short_name
    @test = ServiceComponent::Test::OrchestratorEnvironmentFactory.build(feature)
  rescue
    Cucumber.wants_to_quit = true
    raise
  end
end
