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

admin_user = User.find_or_create_by!(email: "admin@admin.com", name: "Ulloa", phone: "+56900000001") do |user|
  user.password = "salero"
  user.password_confirmation = "salero"
  user.user_role_id = UserRole.find_by(name: 'Admin').id
end
Admin.find_or_create_by!(user_id: admin_user.id)

teacher_user = User.find_or_create_by!(email: "teacher@teacher.com", name: "Profe Rod", phone: "+56900000002") do |user|
  user.password = "salero"
  user.password_confirmation = "salero"
  user.user_role_id = UserRole.find_by(name: 'Teacher').id
end
teacher = Teacher.find_or_create_by!(user_id: teacher_user.id)

student_user = User.find_or_create_by!(email: "student@student.com", name: "Doren", phone: "+56900000003") do |user|
  user.password = "salero"
  user.password_confirmation = "salero"
  user.user_role_id = UserRole.find_by(name: 'Student').id
end
Student.find_or_create_by!(user_id: student_user.id)

course_type = CourseType.find_or_create_by!(name: "Maths", description: "Mathematics courses")
course1 = Course.find_or_create_by!(title: "Maths 101", description: "bla", start_date: Date.today, end_date: Date.tomorrow, course_type: course_type, teacher: teacher)
course2 = Course.find_or_create_by!(title: "Maths 201", description: "ble", start_date: Date.today, end_date: Date.tomorrow, course_type: course_type, teacher: teacher)


Enrollment.find_or_create_by!(student: student_user.student, course: course1, enrollment_date: Date.today)
Enrollment.find_or_create_by!(student: student_user.student, course: course2, enrollment_date: Date.today)


material_type1 = MaterialType.find_or_create_by!(name: "Document", description: "A document type material")
material_type2 = MaterialType.find_or_create_by!(name: "Book", description: "A book used in the course")
material_type3 = MaterialType.find_or_create_by!(name: "Video", description: "A video resource")
material_type4 = MaterialType.find_or_create_by!(name: "Presentation", description: "Slide presentations for the course")

material1 = Material.find_or_create_by!(name: "Introduction to Algebra", description: "Basic algebraic concepts", material_type: material_type1, course: course1)
material2 = Material.find_or_create_by!(name: "Linear Algebra Book", description: "A comprehensive guide to linear algebra", material_type: material_type2, course: course1)
material3 = Material.find_or_create_by!(name: "Algebraic Structures Video", description: "An in-depth look at algebraic structures", material_type: material_type3, course: course1)
material4 = Material.find_or_create_by!(name: "Introduction to Algebra Slides", description: "Slides for the first week of Algebra", material_type: material_type4, course: course1)


material5 = Material.find_or_create_by!(name: "Advanced Calculus Document", description: "A document covering advanced calculus topics", material_type: material_type1, course: course2)
material6 = Material.find_or_create_by!(name: "Calculus Textbook", description: "Advanced calculus textbook", material_type: material_type2, course: course2)
material7 = Material.find_or_create_by!(name: "Introduction to Derivatives Video", description: "Video explaining basic derivatives", material_type: material_type3, course: course2)
material8 = Material.find_or_create_by!(name: "Advanced Calculus Presentations", description: "Slides covering advanced calculus concepts", material_type: material_type4, course: course2)
