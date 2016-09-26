$.ajaxSetup({async: false});

/* Went better than expected. */
function actuallyParseItForReal(repofile)
{
    var rlines = repofile.split("\n");
    var out = {}
    var cPKG = "";

    for(var ln in rlines) {
        var thing = rlines[ln].split("=");

        switch (thing[0].trim()) {
            case "name":
                cPKG = thing[1].trim();
                out[cPKG] = {"name": cPKG};
            case "end":
                break;
            default:
                if (out[cPKG] == null) {
                    console.error("Y u gotta have no name?");
                    break;
                }

                out[cPKG][thing.shift().trim()] = thing.join("=").trim();
        }
    }

    return out;
}

function parseRepoFile(fileURL)
{
    var _data = null;
    $.get(fileURL, function(data) {
        _data = actuallyParseItForReal(data);
    });

    return _data;
}
