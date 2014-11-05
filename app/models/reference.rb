class Reference < ActiveRecord::Base
  def concept
    Concept.where(uuid: concept_uuid).first
  end
end
