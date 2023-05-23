class Battle::Hero
    attr_accessor :name, :attack, :defense, :life, :team

    def initialize(hero)
        @name = hero.name
        @attack = hero.attack
        @defense = hero.defense
        @life = hero.life
        @team = hero.team
    end

end