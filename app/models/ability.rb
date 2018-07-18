class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user && user.is_admin?
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard
      can :manage, :all
    elsif user.is_student?
      can :read, :all
      can :create, Employer
      can :manage, Student

      can [:create, :update], Student do |student|
        student.try(:user_id) == user.id
      end

      can [:create, :update], StudentProfile do |student|
         student.try(:user_id) == user.id
      end
    elsif user.is_employer?
      can :read, :all
      can :create, Employer
      can [:update], Employer do |employer|
        employer.try(:user_id) == user.id
      end

      can [:manage], :employer_wizard
      #can [:manage], :employer_wizard do |employer|
      #   employer.try(:user_id) == user.id
      #end
    else
      can :read, :all
    end
  end
end
