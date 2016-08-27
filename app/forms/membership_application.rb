class MembershipApplication < Member

  delegate :model_name, to: superclass

  validates :full_name, {
    presence: true,
    uniqueness: {
      if: :full_name_changed?,
      message: :already_registered,
      case_sensitive: false,
    },
  }

  validates :email, {
    presence: true,
    uniqueness: {
      if: :email_changed?,
      message: :already_registered,
      case_sensitive: false,
    },
    format: /.+@.+\..+/
  }

  validates :address, presence: true

end
