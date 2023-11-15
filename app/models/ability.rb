# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.admin?
      can :manage, :all # Admin can manage all resources
    elsif user.buyer?
      can :read, Product # Buyers can read products
      can :create, Order # Buyers can create orders
      can :read, Order, buyer_id: user.id # Buyers can read their own orders
      can :update, Order, buyer_id: user.id, status: 'pending' # Buyers can update pending orders
    elsif user.farmer?
      can :manage, Product, farmer_id: user.id # Farmers can manage their own products
      can :read, Order, product: { farmer_id: user.id } # Farmers can read orders for their products
    end
  end
end
