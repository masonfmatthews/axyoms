class Reference < ActiveRecord::Base
  validates :concept_uuid, presence: true
  validates :description, presence: true
  validates :uri, presence: true, format: {with: /\Ahttps?:\/\//, message: "must start with http:// or https://"}

  def concept
    Concept.where(uuid: concept_uuid).first
  end
end
