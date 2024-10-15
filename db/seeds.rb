# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Rails.logger.info "Starting database seeding..."


puts "Creando Roles de Usuario..."
roles = [
  { name: 'Student', description: 'A user who can enroll in courses and participate as a student.' },
  { name: 'Teacher', description: 'A user who can create and manage courses for students.' },
  { name: 'Admin', description: 'A user who can create and manage courses, conversations and users.' }
]

roles.each do |role_data|
  UserRole.find_or_create_by(name: role_data[:name]) do |role|
    role.description = role_data[:description]
  end
end

puts "Creando el usuario de admin..."
admin_user = User.find_or_create_by(email: "admin@admin.com", name: "Ulloa", phone: "+56900000001") do |user|
  user.password = "salero"
  user.password_confirmation = "salero"
  user.user_role_id = UserRole.find_by(name: 'Admin').id
end
Admin.find_or_create_by(user_id: admin_user.id)

puts "Creando el usuario de profesor..."
teacher_user = User.find_or_create_by(email: "teacher@teacher.com") do |user|
  user.name = "Profe Rod"
  user.phone = "+56900000002"
  user.password = "salero"
  user.password_confirmation = "salero"
  user.user_role_id = UserRole.find_by(name: 'Teacher').id
end
teacher = Teacher.find_or_create_by(user_id: teacher_user.id)

puts "Creando el usuario de estudiante..."
student_user = User.find_or_create_by(email: "student@student.com", name: "Doren", phone: "+56900000003") do |user|
  user.password = "salero"
  user.password_confirmation = "salero"
  user.user_role_id = UserRole.find_by(name: 'Student').id
student = Student.find_or_create_by(user_id: student_user.id)

puts "Creando el tipo de curso..."
course_type1 = CourseType.find_or_create_by(name: "Online asíncrono", description: "Cápsulas de videos, pruebas online")
course_type2 = CourseType.find_or_create_by(name: "Online sincronizado", description: "Videoconferencias, pruebas online")
course_type3 = CourseType.find_or_create_by(name: "Mixto", description: "Videoconferencias, pruebas presenciales")
course_type4 = CourseType.find_or_create_by(name: "Presencial", description: "Clases y pruebas presenciales")

puts "Creando los cursos..."
course1 = Course.find_or_create_by(title: "Maths 101", description: "bla", start_date: Date.today, end_date: Date.tomorrow, course_type: course_type1, teacher_id: teacher.id)
course2 = Course.find_or_create_by(title: "Maths 201", description: "ble", start_date: Date.today, end_date: Date.tomorrow, course_type: course_type2, teacher_id: teacher.id)
course3 = Course.find_or_create_by(title: "Language 101", description: "bli", start_date: Date.today, end_date: Date.tomorrow, course_type: course_type3, teacher_id: teacher.id)
course4 = Course.find_or_create_by(title: "Language 201", description: "blo", start_date: Date.today, end_date: Date.tomorrow, course_type: course_type4, teacher_id: teacher.id)


Enrollment.find_or_create_by(student: student_user.student, course_id: course1.id, enrollment_date: Date.today)
Enrollment.find_or_create_by(student: student_user.student, course_id: course2.id, enrollment_date: Date.today)


puts "Creando reseñas de profesor..."
teacher_reviews2 = TeacherReview.find_or_create_by(teacher_id: teacher.id, student_id: student.id, rating: 4, title: "Great Teacher", comment: "Good teacher!")
teacher_reviews1 = TeacherReview.find_or_create_by(teacher_id: teacher.id, student_id: student.id, rating: 5, title: "Excellent Teacher", comment: "Highly recommend!")
teacher_reviews3 = TeacherReview.find_or_create_by(teacher_id: teacher.id, student_id: student.id, rating: 3, title: "Good Teacher", comment: "Average teacher.")

puts "Creando reseñas de curso..."
course_reviews1 = CourseReview.find_or_create_by(course_id: course1.id, student_id: student.id, rating: 5, title: "Excellent Course", comment: "Highly recommend!")
course_reviews2 = CourseReview.find_or_create_by(course_id: course2.id, student_id: student.id, rating: 4, title: "Great Course", comment: "Good course!")
course_reviews3 = CourseReview.find_or_create_by(course_id: course3.id, student_id: student.id, rating: 10, title: "Good Course", comment: "Average course.")
course_reviews4 = CourseReview.find_or_create_by(course_id: course4.id, student_id: student.id, rating: 2, title: "Bad Course", comment: "Poor course.")


material_type1 = MaterialType.find_or_create_by(name: "Document", description: "A document type material")
material_type2 = MaterialType.find_or_create_by(name: "Book", description: "A book used in the course")
material_type3 = MaterialType.find_or_create_by(name: "Video", description: "A video resource")
material_type4 = MaterialType.find_or_create_by(name: "Presentation", description: "Slide presentations for the course")

puts "Creando los materiales de clase..."
material1 = Material.find_or_create_by(name: "Introduction to Algebra", description: "Basic algebraic concepts", material_type: material_type1, course: course1)
material2 = Material.find_or_create_by(name: "Linear Algebra Book", description: "A comprehensive guide to linear algebra", material_type: material_type2, course: course1)
material3 = Material.find_or_create_by(name: "Algebraic Structures Video", description: "An in-depth look at algebraic structures", material_type: material_type3, course: course1)
material4 = Material.find_or_create_by(name: "Introduction to Algebra Slides", description: "Slides for the first week of Algebra", material_type: material_type4, course: course1)

material5 = Material.find_or_create_by(name: "Advanced Calculus Document", description: "A document covering advanced calculus topics", material_type: material_type1, course: course2)
material6 = Material.find_or_create_by(name: "Calculus Textbook", description: "Advanced calculus textbook", material_type: material_type2, course: course2)
material7 = Material.find_or_create_by(name: "Introduction to Derivatives Video", description: "Video explaining basic derivatives", material_type: material_type3, course: course2)
material8 = Material.find_or_create_by(name: "Advanced Calculus Presentations", description: "Slides covering advanced calculus concepts", material_type: material_type4, course: course2)

material9 = Material.find_or_create_by(name: "Videos de Fails", description: "Videos de fails", material_type: material_type3, course: course4)

evaluation_type1 = EvaluationType.find_or_create_by(name: "Quiz", description: "A short quiz")
evaluation_type2 = EvaluationType.find_or_create_by(name: "Final Exam", description: "End of course final exam")

puts "Creando las evaluaciones..."
evaluation1 = Evaluation.find_or_create_by(name: "Algebra Quiz", start_date: Date.today, duration: 60, course: course1, evaluation_type: evaluation_type1)
evaluation2 = Evaluation.find_or_create_by(name: "Linear Algebra Final Exam", start_date: Date.today + 1.week, duration: 120, course: course1, evaluation_type: evaluation_type2)
evaluation3 = Evaluation.find_or_create_by(name: "Calculus Quiz", start_date: Date.today, duration: 60, course: course2, evaluation_type: evaluation_type1)
evaluation4 = Evaluation.find_or_create_by(name: "Advanced Calculus Final Exam", start_date: Date.today + 1.week, duration: 120, course: course2, evaluation_type: evaluation_type2)
evaluation5 = Evaluation.find_or_create_by(name: "Advanced Calculus Final Exam", start_date: Date.today + 1.week, duration: 120, course: course3, evaluation_type: evaluation_type2)

question1_eval1 = EvaluationQuestion.find_or_create_by(content: "What is 2 + 2?", evaluation: evaluation1)
question2_eval1 = EvaluationQuestion.find_or_create_by(content: "What is the derivative of x^2?", evaluation: evaluation1)
question1_eval2 = EvaluationQuestion.find_or_create_by(content: "Define a vector space.", evaluation: evaluation2)
question2_eval2 = EvaluationQuestion.find_or_create_by(content: "What is a basis in linear algebra?", evaluation: evaluation2)
question1_eval3 = EvaluationQuestion.find_or_create_by(content: "What is the integral of x?", evaluation: evaluation3)
question1_eval4 = EvaluationQuestion.find_or_create_by(content: "What is the limit of 1/x as x approaches infinity?", evaluation: evaluation4)

# answer1 = EvaluationAnswer.find_or_create_by(content: "4", points: 0, evaluation_status: 0, evaluation_question: question1_eval1, student: student_user.student)
# answer2 = EvaluationAnswer.find_or_create_by(content: "2x", points: 0, evaluation_status: 0, evaluation_question: question2_eval1, student: student_user.student)
answer3 = EvaluationAnswer.find_or_create_by(content: "A set with two operations", points: 0, evaluation_status: 1, evaluation_question: question1_eval2, student: student_user.student)
answer4 = EvaluationAnswer.find_or_create_by(content: "Set of vectors", points: 0, evaluation_status: 1, evaluation_question: question2_eval2, student: student_user.student)
# answer5 = EvaluationAnswer.find_or_create_by(content: "x^2/2", points: 0, evaluation_status: 0, evaluation_question: question1_eval3, student: student_user.student)
# answer6 = EvaluationAnswer.find_or_create_by(content: "0", points: 0, evaluation_status: 0, evaluation_question: question1_eval4, student: student_user.student)
#Estatus 0 = No respondido
#Estatus 1 = Pregunta respondida


CourseRequestStatus.find_or_create_by(name: "pending", description: "Pending approval")
CourseRequestStatus.find_or_create_by(name: "accepted", description: "Request accepted")
CourseRequestStatus.find_or_create_by(name: "rejected", description: "Request rejected")


