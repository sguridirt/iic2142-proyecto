function dynamizeEvaluationForm() {
  console.log("Initializing evaluation form");
  const addQuestionLink = document.querySelector('#add_question');
  const questionsContainer = document.querySelector('#questions');
  let questionsIndex = document.querySelectorAll('.question-field').length + 1; // Hubo que agregar esto y modificarlo

  // Hubo que agregar esto
  if (!questionsContainer) {
    return;
  }

  if (addQuestionLink) {
    addQuestionLink.addEventListener('click', (e) => {
      console.log("Adding new question");
      e.preventDefault();
      const newQuestion = document.createElement('div');
      newQuestion.classList.add('question-field');
//       // Hubo que cambiar esto
      newQuestion.innerHTML = `
        <div class="form-group mb-3">
          <label for="evaluation_evaluation_questions_attributes_${questionsIndex}_content">Contenido pregunta</label>
          <textarea name="evaluation[evaluation_questions_attributes][${questionsIndex}][content]" id="evaluation_evaluation_questions_attributes_${questionsIndex}_content" class="form-control"></textarea>
          <a href="#" class="remove-question">Remove</a>
        </div>`;
      questionsContainer.appendChild(newQuestion);
      questionsIndex++;
    });
  }

  questionsContainer.addEventListener('click', (e) => {
    if (e.target.classList.contains('remove_question')) {
      e.preventDefault();
      e.target.closest('.question-field').remove();
    }
  });
}

document.addEventListener('turbo:render', dynamizeEvaluationForm); // Hubo que usar turbo:render en vez de turbo:load