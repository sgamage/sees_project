module HomeHelper
  def application_id(id)
    "#{id.to_s.rjust(10,'0')}"
  end
  
  def applciation_status(id)
    ApplicationStatus.find(id).try(:status)
  end
  
end
