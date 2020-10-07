class MedicalHistory < ApplicationRecord
  belongs_to :user
  belongs_to :dependent, optional: true
end
