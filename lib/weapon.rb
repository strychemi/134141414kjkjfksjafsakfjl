class Weapon
  attr_reader :name, :damage

  def initialize(name, damage=0)
    raise ArgumentError, "Name must be a String!" unless name.is_a?(String)
    raise ArgumentError, "Damage must be a Fixnum!" unless damage.is_a?(Fixnum)
    @name = name
    @damage = damage

  end
end
