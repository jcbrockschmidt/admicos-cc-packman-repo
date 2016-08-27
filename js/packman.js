function parseRepoFile(fileURL)
{
    $.get(fileURL, function(data) {
        alert(data);
    });
}
