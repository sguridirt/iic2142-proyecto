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

course_type1 = CourseType.find_or_create_by!(name: "Online asíncrono", description: "Cápsulas de videos, pruebas online")
course_type2 = CourseType.find_or_create_by!(name: "Online sincronizado", description: "Videoconferencias, pruebas online")
course_type3 = CourseType.find_or_create_by!(name: "Mixto", description: "Videoconferencias, pruebas presenciales")
course_type4 = CourseType.find_or_create_by!(name: "Presencial", description: "Clases y pruebas presenciales")

course1 = Course.find_or_create_by!(title: "Maths 101", description: "bla", start_date: Date.today, end_date: Date.tomorrow, course_type: course_type1, teacher: teacher)
course2 = Course.find_or_create_by!(title: "Maths 201", description: "ble", start_date: Date.today, end_date: Date.tomorrow, course_type: course_type2, teacher: teacher)
course3 = Course.find_or_create_by!(title: "Language 101", description: "bli", start_date: Date.today, end_date: Date.tomorrow, course_type: course_type3, teacher: teacher)
course4 = Course.find_or_create_by!(title: "Language 201", description: "blo", start_date: Date.today, end_date: Date.tomorrow, course_type: course_type4, teacher: teacher)


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

material9 = Material.find_or_create_by!(name: "Videos de Fails", description: "Videos de fails", material_type: material_type3, course: course4)

evaluation_type1 = EvaluationType.find_or_create_by!(name: "Quiz", description: "A short quiz")
evaluation_type2 = EvaluationType.find_or_create_by!(name: "Final Exam", description: "End of course final exam")

evaluation1 = Evaluation.find_or_create_by!(name: "Algebra Quiz", start_date: Date.today, duration: 60, course: course1, evaluation_type: evaluation_type1)
evaluation2 = Evaluation.find_or_create_by!(name: "Linear Algebra Final Exam", start_date: Date.today + 1.week, duration: 120, course: course1, evaluation_type: evaluation_type2)
evaluation3 = Evaluation.find_or_create_by!(name: "Calculus Quiz", start_date: Date.today, duration: 60, course: course2, evaluation_type: evaluation_type1)
evaluation4 = Evaluation.find_or_create_by!(name: "Advanced Calculus Final Exam", start_date: Date.today + 1.week, duration: 120, course: course2, evaluation_type: evaluation_type2)
evaluation5 = Evaluation.find_or_create_by!(name: "Advanced Calculus Final Exam", start_date: Date.today + 1.week, duration: 120, course: course3, evaluation_type: evaluation_type2)

question1_eval1 = EvaluationQuestion.create!(content: { question: "What is 2 + 2?", options: ["3", "4", "5"], correct_answer: "4" }, evaluation: evaluation1)
question2_eval1 = EvaluationQuestion.create!(content: { question: "What is the derivative of x^2?", options: ["2x", "x^2", "2"], correct_answer: "2x" }, evaluation: evaluation1)
question1_eval2 = EvaluationQuestion.create!(content: { question: "Define a vector space.", options: ["A set of points", "A set with two operations", "A linear equation"], correct_answer: "A set with two operations" }, evaluation: evaluation2)
question2_eval2 = EvaluationQuestion.create!(content: { question: "What is a basis in linear algebra?", options: ["Set of vectors", "A scalar", "A number"], correct_answer: "Set of vectors" }, evaluation: evaluation2)
question1_eval3 = EvaluationQuestion.create!(content: { question: "What is the integral of x?", options: ["x", "x^2/2", "1/x"], correct_answer: "x^2/2" }, evaluation: evaluation3)
question1_eval4 = EvaluationQuestion.create!(content: { question: "What is the limit of 1/x as x approaches infinity?", options: ["0", "Infinity", "1"], correct_answer: "0" }, evaluation: evaluation4)

answer1 = EvaluationAnswer.find_or_create_by!(content: "4", points: 10, evaluation_status: 1, evaluation_question: question1_eval1, student: student_user.student)
answer2 = EvaluationAnswer.find_or_create_by!(content: "2x", points: 10, evaluation_status: 1, evaluation_question: question2_eval1, student: student_user.student)

answer3 = EvaluationAnswer.find_or_create_by!(content: "A set with two operations", points: 10, evaluation_status: 1, evaluation_question: question1_eval2, student: student_user.student)
answer4 = EvaluationAnswer.find_or_create_by!(content: "Set of vectors", points: 10, evaluation_status: 1, evaluation_question: question2_eval2, student: student_user.student)
answer5 = EvaluationAnswer.find_or_create_by!(content: "x^2/2", points: 10, evaluation_status: 1, evaluation_question: question1_eval3, student: student_user.student)
answer6 = EvaluationAnswer.find_or_create_by!(content: "0", points: 10, evaluation_status: 1, evaluation_question: question1_eval4, student: student_user.student)

CourseRequestStatus.create(name: "pending", description: "Pending approval")
CourseRequestStatus.create(name: "accepted", description: "Request accepted")
CourseRequestStatus.create(name: "rejected", description: "Request rejected")

