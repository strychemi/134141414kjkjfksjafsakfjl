require 'battle_bot'

class Weapon
  attr_reader :name, :damage, :bot

  def initialize(name, damage=0)
    raise ArgumentError, "Name must be a String!" unless name.is_a?(String)
    raise ArgumentError, "Damage must be a Fixnum!" unless damage.is_a?(Fixnum)
    @name = name
    @damage = damage
    @bot = nil
  end

  def bot=(battlebot)
    raise ArgumentError unless battlebot.is_a?(BattleBot) ^ battlebot.nil?
    @bot = battlebot
  end

  def picked_up?
    if @bot
      return true
    else
      return false
    end
  end
end
