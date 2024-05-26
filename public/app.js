function createApplication() {
    const userId = document.getElementById('user_id').value;
    const charityId = document.getElementById('charity_id').value;
    const alertDiv = document.getElementById('alert');

    fetch('/api/create-application', {
        method: 'POST',
        body: JSON.stringify({ user_id: userId, charity_id: charityId }),
        headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content') }
    })
    .then(response => response.json())
    .then(data => {
        alertDiv.style.display = 'block';
        alertDiv.className = 'alert alert-success';
        alertDiv.innerText = data.message;
    })
    .catch(error => {
        alertDiv.style.display = 'block';
        alertDiv.className = 'alert alert-error';
        alertDiv.innerText = 'An error occurred. Please try again.';
        console.error('Error:', error);
    });
}
