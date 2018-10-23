class Package < ActiveRecord::Base
  # Validations
  validates  :name, :version, :publication_date, :title, :description, :authors, :maintainers,
    presence: true
end
