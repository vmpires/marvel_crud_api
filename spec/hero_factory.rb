class HeroFactory
    class << self
        def create_hero(name="Victor")
            Hero.create!(
                name: name,
                attack: 100,
                defense: 50,
                life: 500,
                team: 0
            )
        end
        
        def valid_object
            {
                name: "Victor",
                attack: 50,
                defense: 50,
                life: 500,
                team: "con_registry"
            }
        end
        
        def invalid_object
            {
                name: "Victor",
                attack: "string",
                defense: 50,
                life: 500,
                team: "con_registry"
            }
        end
        
        def invalid_argument_object
            {
                name: "Victor",
                attack: 50,
                defense: 50,
                life: 500,
                team: 0
            }
        end
    end
end