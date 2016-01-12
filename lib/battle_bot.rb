require 'weapon'

class BattleBot

  attr_reader :name, :health, :enemies, :weapon

  def initialize(name, health=100)
    raise ArgumentError, "No Name is passed!" if !name.is_a?(String) && name.length == 0
    @name = name
    @health = health
    @enemies = []
    @weapon = nil
  end

  def dead?
    if @health > 0
      return false
    else
      return true
    end
  end

  def has_weapon?
    if @weapon
      return true
    else
      return false
    end
  end

  def pick_up(weapon)
    raise ArgumentError unless weapon.is_a?(Weapon)
    #raise ArgumentError unless weapon.picked_up?
    if @weapon
      return nil
    else
      @weapon = weapon
      @weapon.bot = self
      return weapon
    end
  end

  def drop_weapon
    @weapon.bot = nil
    @weapon = nil
  end

  def take_damage(damage)
    raise ArgumentError unless damage.is_a?(Fixnum)
    if damage > @health
      @health = 0
    else
      @health -= damage
    end

  end
end
