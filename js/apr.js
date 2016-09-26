$(document).ready(function() {
    var pkg_template = `
    <div class="col-md-6">
        <div class="panel panel-default">
            <div class="panel-heading"><a href="{5}"><h2 class="panel-title">{0}</h2></a></div>
            <div class="panel-body">
                <b>Categories:      </b>{1}<br>
                <b>Version:         </b>{2}<br>
                <b>Size:            </b>{3}<br>
                <b>Dependencies:    </b>{4}<br>
            </div>
        </div>
    </div>`;

    var repo_url = "https://raw.githubusercontent.com/Admicos/cc-packman-repo/master/repo";
    var loader   = $("#loading");
    var pkgs     = $("#packages");
    var repofile = parseRepoFile(repo_url);

    var pkg_html = "";

    for(var thing in repofile) {
        var pkg = repofile[thing];

        pkg_html += pkg_template.format(pkg["name"], pkg["category"].replace(" ", ", "),
                                        pkg["version"], pkg["size"],
                                        pkg["dependencies"], pkg["--link"]);
    }

    loader.css({"display": "none"});
    pkgs.html(pkg_html);

    alert(pkg_html);
});
