document.addEventListener('turbo:load', () => {
  
  // Inicializar el temporizador
  const initTimer = () => {
    const countdownElement = document.getElementById('countdown');
    if (countdownElement) {
      let duration = parseInt(countdownElement.dataset.duration) * 60; // Convertir duración de minutos a segundos
      const form = document.querySelector('form'); // Selecciona el formulario de las respuestas

      const timerInterval = setInterval(() => {
        if (duration <= 0) {
          clearInterval(timerInterval);
          countdownElement.textContent = '¡Tiempo agotado!';

          // Enviar el formulario automáticamente cuando el tiempo se acabe
          if (form) {
            form.submit();
          }

        } else {
          const minutes = Math.floor(duration / 60);
          const seconds = duration % 60;
          countdownElement.textContent = `${minutes}:${seconds < 10 ? '0' + seconds : seconds}`;
          duration--;
        }
      }, 1000); // Actualizar cada segundo
    }
  };

  // Inicializar la funcionalidad de agregar y eliminar preguntas
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
          <label for="evaluation_evaluation_questions_attributes_${questionIndex}_content">Contenido pregunta</label>
          <textarea name="evaluation[evaluation_questions_attributes][${questionIndex}][content]" id="evaluation_evaluation_questions_attributes_${questionIndex}_content" class="form-control"></textarea>
          <input type="hidden" name="evaluation[evaluation_questions_attributes][${questionIndex}][_destroy]" value="false">
          <a href="#" class="remove_question">Eliminar</a>
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

  // Llamar las funciones separadamente
  initTimer();      // Inicializar el temporizador
  initQuestions();  // Inicializar la funcionalidad de las preguntas

});
