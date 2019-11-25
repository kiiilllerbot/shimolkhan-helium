class Ability
  include CanCan::Ability

  def initialize(user)  
    user ||= User.new
    if user.admin?
        can :manage, :all
    else
        can :update, Post, user_id: user.id
        can :destroy, Post, user_id: user.id
        
        can :read, Post
        can :read, Category
        can :create, Post
    end
  end
end