# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  [
    "Alice Doe",
    "Beatrice Doe",
    "Carl Doe",
    "Dan Doe"
  ].each do |full_name|
    Member.find_or_initialize_by(full_name:).tap do |member|
      member.email = %(#{full_name.downcase.tr(" ", ".")}@example.com)
      member.save if member.new_record?
    end
  end
end
