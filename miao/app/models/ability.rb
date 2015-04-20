class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, :to => :modify
    alias_action :create, :read, :update, :destroy, :to => :crud
    user ||= User.new  # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :miao
      can :manage, Twitter, :user_id => user.id
      can :manage, User
    else
      can :read, :all
    end

    # can :manage, Article  # user can perform any action on the article
    # can :read, :all       # user can read any object
    # can :manage, :all     # user can perform any action on any object
    # can :update, Article
    # :read, :create, :update and :destroy
  end
end
