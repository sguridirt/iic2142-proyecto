function initializeTimer(duration) {
  const durationInSeconds = duration * 60; // Convertir minutos a segundos

  // Función para formatear el tiempo en mm:ss
  function formatTime(seconds) {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes}:${remainingSeconds < 10 ? '0' : ''}${remainingSeconds}`;
  }

  // Función para enviar el formulario automáticamente
  function submitForm() {
    const form = document.querySelector('form');
    form.submit();
  }

  let timeRemaining = durationInSeconds;
  const countdownElement = document.getElementById('countdown');

  const interval = setInterval(() => {
    countdownElement.innerText = formatTime(timeRemaining);

    // Cuando el tiempo se acaba
    if (timeRemaining <= 0) {
      clearInterval(interval);
      submitForm(); // Enviar el formulario automáticamente
    }

    timeRemaining--;
  }, 1000);
}

// Inicializar el temporizador cuando se cargue la página
document.addEventListener('turbo:load', () => {
  const countdownElement = document.getElementById('countdown');
  
  if (countdownElement) {
    const duration = parseInt(countdownElement.dataset.duration); // Obtener la duración desde el dataset
    initializeTimer(duration); // Iniciar el temporizador con la duración
  }
});
