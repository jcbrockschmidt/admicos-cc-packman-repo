var repo_url = "https://raw.githubusercontent.com/Admicos/cc-packman-repo/master/repo";
var repofile = parseRepoFile(repo_url);

//Not using pastebin.com since it doesn't have CORS headers and JS doesn't like it.
var pastebin_url = "https://admicos.cf/stuff/pb.php?p={0}"

var pkg_html = "";
var pkg_template = `
<div class="col-md-4">
    <div class="panel panel-default">
        <div class="panel-heading"><a href="{5}"><h2 class="panel-title">{0}</h2></a></div>
        <div class="panel-body">
            <b>Categories:      </b>{1}<br>
            <b>Version:         </b>{2}<br>
            <b>Size:            </b>{3}<br>
            <b>Dependencies:    </b>{4}<br>
        </div>

        <button href="#!" onclick='preview("{0}");' class="btn btn-link">View Code</button>
    </div>
</div>`;

var prev_modal = `
<div class="modal fade" id="codemodal" tabindex="-1" role="dialog" aria-labelledby="code modal.">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">Code for {0}</h4>
      </div>
      <div class="modal-body">
        <pre class="line-numbers"><code class="language-lua">{1}</code></pre>
      </div>
    </div>
  </div>
</div>
`;

/* ==== FUNCTIONS ==== */
function preview(pkg)
{
    var pkg = repofile[pkg];
    var mcon = $("#modal-container");
    var _url = ""

    if (pkg["type"] == "raw")
        _url = pkg["url"];
    else if (pkg["type"] == "pastebin")
        _url = pastebin_url.format(pkg["url"]);
    else if (pkg["type"] == "github" || pkg["type"] == "bitbucket" || pkg["type"] == "grin") {
        alert("Viewing code for git based projects are not supported!");
        return;
    } else  {
        alert("This is a meta package, which means there is no code for it.");
        return;
    }

    $.get(_url, function(data) {
        mcon.html(prev_modal.format(pkg["name"], data));
        Prism.highlightAll(true, function(){
            $("#codemodal").modal();
        });
    });
}

$(document).ready(function()
{
    var loader   = $("#loading");
    var pkgs     = $("#packages");

    /* ==== LOAD PACKAGES ==== */
    for(var thing in repofile) {
        var pkg = repofile[thing];

        pkg_html += pkg_template.format(pkg["name"], pkg["category"].replace(" ", ", "),
                                        pkg["version"], pkg["size"],
                                        pkg["dependencies"], pkg["--link"]);
    }

    loader.css({"display": "none"});
    pkgs.html(pkg_html);
});
