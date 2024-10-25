document.addEventListener('turbo:load', () => {
  
  const initTimer = () => {
    const countdownElement = document.getElementById('countdown');
    if (countdownElement) {
      let duration = parseInt(countdownElement.dataset.duration) * 60;
      const form = document.querySelector('form');

      const timerInterval = setInterval(() => {
        if (duration <= 0) {
          clearInterval(timerInterval);
          countdownElement.textContent = '¡Tiempo agotado!';


          if (form) {
            form.submit();
          }

        } else {
          const minutes = Math.floor(duration / 60);
          const seconds = duration % 60;
          countdownElement.textContent = `${minutes}:${seconds < 10 ? '0' + seconds : seconds}`;
          duration--;
        }
      }, 1000); 
    }
  };

  const initQuestions = () => {
    const addQuestionLink = document.getElementById('add_question');
    const questionsContainer = document.getElementById('questions');
    let questionIndex = document.querySelectorAll('.question-field').length;

    if (addQuestionLink) {
      addQuestionLink.addEventListener('click', (e) => {
        e.preventDefault();

        const newQuestion = document.createElement('div');
        newQuestion.classList.add('form-group', 'mb-3', 'question-field');
        newQuestion.innerHTML = `
          <div class="form-group mb-3 question-field card p-3">
              <span class="fw-bold mb-4">Pregunta</span>
              <label for="evaluation_evaluation_questions_attributes_${questionIndex}_content">Enunciado</label>
              <textarea class="form-control" name="evaluation[evaluation_questions_attributes][${questionIndex}][content]" id="evaluation_evaluation_questions_attributes_${questionIndex}_content"></textarea>
              <input autocomplete="off" type="hidden" value="false" name="evaluation[evaluation_questions_attributes][${questionIndex}][_destroy]" id="evaluation_evaluation_questions_attributes_${questionIndex}__destroy">
              <label for="evaluation_evaluation_questions_attributes_${questionIndex}_max_points">Puntaje máximo</label>
              <input class="form-control mb-4" type="number" name="evaluation[evaluation_questions_attributes][${questionIndex}][max_points]" id="evaluation_evaluation_questions_attributes_${questionIndex}_max_points">
              <button class="remove_question btn btn-small btn-outline-danger">Eliminar</button>
          </div>
        `;
        questionsContainer.appendChild(newQuestion);
        questionIndex++;
      });
    }

    questionsContainer.addEventListener('click', (e) => {
      if (e.target.classList.contains('remove_question')) {
        e.preventDefault();
        e.target.closest('.question-field').remove();
      }
    });
  };


  initTimer();      
  initQuestions();  

});
