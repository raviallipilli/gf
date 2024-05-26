<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports</title>
    <style>
     
        #report-list {
            max-width: 600px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
            margin: auto;
        }
    </style>
</head>
<body>
    <h1>Reports</h1>
    <div id="report-list">
    <strong id="responseText" style="margin:50px"></strong>

        <!-- Reports will be dynamically added here -->
    </div>

    <script>
        // Function to fetch and display reports
        function fetchReports() {
            var url = window.location.href;
            var urlString = url.split('/');
            var id = urlString[3];
            console.log(id);
            fetch('/api/'+id+'/see-reports')
                .then(response => response.json())
                .then(data => {
                    const reportList = document.getElementById('report-list');
                    const responseText = document.getElementById('responseText');

                    // display the response
                   responseText.innerText = data.message;

                    // Iterate over fetched reports and create HTML elements
                    data.reports.forEach(report => {
                        const reportItem = document.createElement('div');
                        reportItem.classList.add('report-item');
                        console.log(report);

                        reportItem.innerHTML = `
                            <h2>${report.user.name}</h2>
                            <p>Application ID: ${report.id}</p>
                            <p>Charity Name: ${report.charity.charity_name}</p>
                            <p>Stage: ${report.stage}</p>
                            <p>Application Date Created: ${report.date_created}</p>
                        `;
                        reportList.appendChild(reportItem);
                    });
                })
                .catch(error => {
                    console.error('Error fetching reports:', error);
                });
        }

        // Fetch reports when the page loads
        window.onload = fetchReports;
    </script>
</body>
</html>
