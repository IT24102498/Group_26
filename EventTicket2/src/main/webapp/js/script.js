document.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const eventId = urlParams.get('eventId');
    if (eventId) {
        document.getElementById('eventId').value = eventId;
    }

    const bookingForm = document.getElementById('bookingForm');
    if (bookingForm) {
        bookingForm.addEventListener('submit', (e) => {
            const userName = document.getElementById('userName').value;
            const seat = document.getElementById('seat').value;
            if (!userName || !seat) {
                e.preventDefault();
                alert('Please fill in all fields.');
            }
        });
    }
});