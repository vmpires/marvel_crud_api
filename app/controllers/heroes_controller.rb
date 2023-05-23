class HeroesController < ApplicationController
  def index
    @heroes = Hero.all.order(id: :asc)
    if @heroes
      render json: @heroes
    else
      render status: 204
    end
  end

  def show
    @hero = Hero.find_by(id: params[:id])

    if @hero.nil?
      hero_not_found
    else
      render json: @hero
    end
  end

  def create
    @hero = Hero.new(hero_params)
    if @hero.save
      render json: @hero, status: :created, location: @hero
    else
      render json: @hero.errors, status: :unprocessable_entity
    end
  end

  def update
    @hero = Hero.find_by(id: params[:id])

    if @hero.nil?
      hero_not_found
      return
    end

    if @hero.update(hero_params)
      render json: @hero
    else
      render json: { errors: @hero.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @hero = Hero.find_by(id: params[:id])

    if @hero.nil?
      hero_not_found
      return
    else
      @hero.destroy
    end

    render json: { deleted: @hero }
  end

  def battle
    unless valid_params
      render json: {
        error: 'con_registry_team or pro_registry_team parameter missing...'
      }, status: :unprocessable_entity
      return
    end

    con_registry_team = Hero.where(id: params[:con_registry_team]).to_a
    pro_registry_team = Hero.where(id: params[:pro_registry_team]).to_a

    if con_registry_team.empty? && pro_registry_team.empty?
      render json: {
        error: "Both teams are empty or no hero was found..."
        }, status: :unprocessable_entity

    elsif con_registry_team.empty? || pro_registry_team.empty?
      empty_team = con_registry_team.empty? ? 'con_registry_team' : 'pro_registry_team'
      render json: {
        error: "#{empty_team} is empty or their heroes were not found..."
        }, status: :unprocessable_entity

    elsif con_registry_team.map { |h| h[:team] }.uniq.length > 1 || pro_registry_team.map { |h| h[:team] }.uniq.length > 1
      render json: {
        error: "There's a spy around, maybe Loki... Some heroes don't belong their teams..."
        },status: :unprocessable_entity

    elsif con_registry_team[0].team == pro_registry_team[0].team
      render json: {
        error: "Those heroes are on the same team on Civil War!"
        }, status: :unprocessable_entity

    elsif con_registry_team[0].team == "pro_registry" || pro_registry_team[0].team == "con_registry"
      render json: {error: "Oops, those teams are swapped, heroes should belong their teams!"}, status: :unprocessable_entity

    else
      result = Battle::Base.new(con_registry_team, pro_registry_team).start_battle
      render json: { result: result }
    end

  end

  private

  def hero_params
    params.require(:hero).permit(:name, :attack, :defense, :life, :team)
  end

  def hero_not_found
    render json: { error: "Hero #{params[:id]} not found!" }, status: :not_found
  end

  def valid_params
    if params.key?(:con_registry_team) && params.key?(:pro_registry_team)
      return true
    end

    false
  end

end
