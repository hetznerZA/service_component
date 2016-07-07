require "soar_auditor_api"

module ServiceComponent
  class RejectingTestAuditor < SoarAuditorApi::AuditorAPI
    #inversion of control method required by the AuditorAPI
    def configuration_is_valid?(configuration)
      true
    end

    #inversion of control method required by the AuditorAPI
    def audit(audit_data)
      raise "Rejecting all audit events for test purposes"
    end
  end
end
