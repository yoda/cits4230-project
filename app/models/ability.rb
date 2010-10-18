class Ability
  include CanCan::Ability
  
  attr_reader :user
  
  def initialize(user)
    @user = user
    
    can :manage, :all if user.admin?
    
    can :manage, Site do |site|
      site.owner == user
    end
    
  end
  
end
