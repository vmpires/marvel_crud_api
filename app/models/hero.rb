class Hero < ActiveRecord::Base
    self.table_name = "heroes"
    enum team: { con_registry: 0, pro_registry: 1 }

    validates :name, presence: true
    validates :attack, presence: true, numericality: { only_integer: true }
    validates :defense, presence: true, numericality: { only_integer: true }
    validates :life, presence: true, numericality: { only_integer: true }
    validates :team, presence: true
end
