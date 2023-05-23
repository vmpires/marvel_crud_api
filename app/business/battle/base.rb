class Battle::Base
    def initialize(con_registry_team, pro_registry_team)
        @con_registry_team = con_registry_team.map {|h| Battle::Hero.new(h) }
        @pro_registry_team = pro_registry_team.map {|h| Battle::Hero.new(h) }
        @battle_stats = { battle: { con_registry_team: @con_registry_team.map(&:name) , pro_registry_team: @pro_registry_team.map(&:name) } }
        @battle_ended = false
        @turn_counter = 1
        @round_counter = 1
    end

    def start_battle
        @attacker_team, @defender_team = set_order

        while !@battle_ended
            run_turn
            @attacker_team, @defender_team = @defender_team, @attacker_team
        end

        return @battle_stats
    end

    def run_turn
        if @attacker_team.present? and @defender_team.present?

            for attacker in @attacker_team do
                return unless @defender_team.present?
                attack_points = rand(attacker.attack)
                defender = @defender_team.sample
                defense_points = rand(defender.defense)
                damage = attack_points - defense_points
                defender.life -= damage if damage > 0
                check_defenders_life
                log_turn(attack_points, defense_points, damage, attacker, defender)
                @round_counter += 1
            end
            @turn_counter += 1
            @round_counter = 1
            return
        end

        @battle_stats[:winner_team] = @attacker_team.present? ? @attacker_team[0].team : @defender_team[0].team
        @battle_ended = true
    end

    def set_order
        order = [@con_registry_team, @pro_registry_team].shuffle
        return order.first, order.last
    end

    def check_defenders_life
        @defender_team = @defender_team.select { |h| h.life > 0  }
    end

    def log_turn(attack_points, defense_points, damage, attacker, defender)
        @battle_stats[:turns] ||= {}
        @battle_stats[:turns]["turn#{@turn_counter}"] ||= {}
        @battle_stats[:turns]["turn#{@turn_counter}"]["round#{@round_counter}"] = { 
            attacker: attacker.name,
            defender: defender.name,
            attack_points: attack_points,
            defense_points: defense_points,
            damage_dealt: damage,
            remaining_attacker_team_life: attacker.life,
            remaining_defender_team_life: defender.life
        }
    end

end