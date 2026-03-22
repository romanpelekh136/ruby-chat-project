class RoomPolicy < ApplicationPolicy
  def destroy?
    user.admin? || record.user == user
  end

  def update?
    user.admin? || record.user == user
  end
end
