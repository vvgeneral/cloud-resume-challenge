const apiUrl = 'https://g45nra4tah.execute-api.us-east-1.amazonaws.com/visitorcount'; 

fetch(apiUrl)
    .then(response => response.json())
    .then(data => {
        document.getElementById('visitorCount').innerText = `Visitor Count: ${data}`;
    })
    .catch(error => {
        console.error('Error:', error); 
    });
