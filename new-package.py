"""Create new packman package in repofile"""

from __future__ import print_function
import os


def main():
#	try: input = raw_input
#	except NameError: pass

	repofile = "repo"
	repourl = "https://raw.githubusercontent.com/Admicos/cc-packman-repo/master"
	pkgstr = ""

	pkg = {"name": input("Package Name: "), "version": input("Package Version: "),
		   "categories": input("Package Categories: "),
		   "size": None, "dependencies": input("Package Dependencies (split by spaces): "),
		   "link": input("Package link (for README.md): ")}

	try:
		pkg["size"] = os.stat(pkg["name"] + os.path.sep + pkg["name"] + ".lua").st_size
	except FileNotFoundError as fnfe:
		print("\nFile not found: " + pkg["name"] + os.path.sep + pkg["name"] + ".lua")
		print("Are you sure you have the package in the repo?")
		return 1

	if not pkg["dependencies"].strip():
		pkg["dependencies"] = "none"

	pkg = ("""name = {name}
	type = raw
		url = {repourl}/{name}/{name}.lua
		filename = {name}
	category = {categories}
	version = {version}
	size = {size}
	dependencies = {dependencies}
	--link = {link}
end""".format(name = pkg["name"], repourl = repourl, categories= pkg["categories"],
			  version = pkg["version"], size = pkg["size"], dependencies = pkg["dependencies"],
			  link = pkg["link"]))

	with open(repofile, "r") as f:
		repo = f.read()

	with open(repofile, "w") as f:
		f.write(repo)
		f.write("\n" + pkg)

	return 0


if __name__ == '__main__':
	exit(main())
