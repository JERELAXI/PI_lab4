let formDataArray = [];

function handleSubmit(event) {
    event.preventDefault();
    const form = document.getElementById("libraryForm");
    const formData = new FormData(form);

    const data = {
        firstname: formData.get("firstname"),
        lastname: formData.get("lastname"),
        middlename: formData.get("middlename"),
        address: formData.get("address"),
        passport: formData.get("passport"),
        reader_status: formData.get("reader_status")
    };

    formDataArray.push(data);
    saveToFiles(data);
    displayData();
    form.reset();
}

function saveToFiles(data) {
    const jsonData = JSON.stringify(data, null, 2);
    console.log("JSON:", jsonData);
    const jsonBlob = new Blob([jsonData], { type: "application/json" });
    const jsonUrl = URL.createObjectURL(jsonBlob);
    downloadFile(jsonUrl, "user_data.json");

    const xmlData = `<?xml version="1.0" encoding="UTF-8"?>
<reader>
    <firstname>${data.firstname}</firstname>
    <lastname>${data.lastname}</lastname>
    <middlename>${data.middlename}</middlename>
    <address>${data.address}</address>
    <passport>${data.passport}</passport>
    <reader_status>${data.reader_status}</reader_status>
</reader>`;
    const xmlBlob = new Blob([xmlData], { type: "application/xml" });
    const xmlUrl = URL.createObjectURL(xmlBlob);
    downloadFile(xmlUrl, "user_data.xml");
}

function downloadFile(url, filename) {
    const link = document.createElement("a");
    link.href = url;
    link.download = filename;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

function displayData() {
    const output = document.getElementById("output");
    output.textContent = JSON.stringify(formDataArray, null, 2);
}

function readData() {
    displayData();
}

function deleteData() {
    formDataArray = [];
    displayData();
}