class LibraryPolicy < ApplicationPolicy
  def destroy?
    user.admin?
  end
end