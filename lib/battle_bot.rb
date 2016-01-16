require 'weapon'

class BattleBot

  @@count = 0

  attr_reader :name, :health, :enemies, :weapon

  def initialize(name, health=100)
    raise ArgumentError, "No Name is passed!" if !name.is_a?(String) && name.length == 0
    @name = name
    @health = health
    @enemies = []
    @weapon = nil
    @@count += 1
  end

  def dead?
    if @health > 0
      return false
    else
      return true
    end
  end

  def has_weapon?
    @weapon ? true : false
  end

  def pick_up(weapon)
    raise ArgumentError unless weapon.is_a?(Weapon)
    if @weapon
      return nil
    else
      raise ArgumentError if weapon.picked_up?
      @weapon = weapon
      @weapon.bot = self
      return @weapon
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
    return @health
  end

  def heal
    unless dead?
      @health += 10
      @health = 100 if @health > 100
    end
    return @health
  end

  def attack(victim)
    raise ArgumentError unless victim.is_a?(BattleBot)
    raise ArgumentError if self == victim
    raise ArgumentError unless @weapon
    victim.receive_attack_from(self)
  end

  def receive_attack_from(attacker)
    raise ArgumentError unless attacker.is_a?(BattleBot)
    raise ArgumentError if self == attacker
    raise ArgumentError unless attacker.has_weapon?
    self.take_damage(attacker.weapon.damage)
    @enemies << attacker unless @enemies.include?(attacker)
    self.defend_against(attacker)
  end

  def take_damage(damage)
    raise ArgumentError unless damage.is_a?(Fixnum)
    if @health < damage
      @health = 0
      @@count -= 1
    else
      @health -= damage
    end
    return @health
  end

  def defend_against(attacker)
    attack(attacker) if !dead? && has_weapon?
  end

  def self.count
    return @@count
  end
end
