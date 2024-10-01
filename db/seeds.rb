# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Create user roles if they don't already exist
roles = [
  { name: 'Student', description: 'A user who can enroll in courses and participate as a student.' },
  { name: 'Teacher', description: 'A user who can create and manage courses for students.' },
  { name: 'Admin', description: 'A user who can create and manage courses, conversations and users.' }
]

# Create roles only if they don't exist already
roles.each do |role_data|
  UserRole.find_or_create_by!(name: role_data[:name]) do |role|
    role.description = role_data[:description]
  end
end
