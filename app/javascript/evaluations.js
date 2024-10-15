function initializeTimer(duration) {
  const durationInSeconds = duration * 60; 

  function formatTime(seconds) {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes}:${remainingSeconds < 10 ? '0' : ''}${remainingSeconds}`;
  }

  function submitForm() {
    const form = document.querySelector('form');
    form.submit();
  }

  let timeRemaining = durationInSeconds;
  const countdownElement = document.getElementById('countdown');

  const interval = setInterval(() => {
    countdownElement.innerText = formatTime(timeRemaining);


    if (timeRemaining <= 0) {
      clearInterval(interval);
      submitForm(); // Enviar el formulario automáticamente
    }

    timeRemaining--;
  }, 1000);
}


document.addEventListener('turbo:load', () => {
  const countdownElement = document.getElementById('countdown');
  
  if (countdownElement) {
    const duration = parseInt(countdownElement.dataset.duration); 
    initializeTimer(duration); 
  }
});
