document.addEventListener('turbo:load', () => {
    const messageDateTimes = document.querySelectorAll('.message-datetime');
    messageDateTimes.forEach(function (element) {
        const utcTime = element.getAttribute('data-utc');
        const localTime = new Date(utcTime).toLocaleString();
        element.textContent = localTime;
    });
});