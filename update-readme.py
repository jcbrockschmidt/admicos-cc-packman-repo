"""Updates README.md file of packman repos to contain all packages (and versions)"""

from __future__ import print_function
import re

repoFile = "repo"
readme_header = """# Admicos's packman repository
My repo for [lyqyd/cc-packman](https://github.com/lyqyd/cc-packman)

## Currently Includes:
"""
readme_footer = """Also, the [LICENSE](/LICENSE) file applies to all the files in this repo, unless specified otherwise.
"""


def main():
	"""Main function"""

	print("Opening repository file")
	with open(repoFile, "r") as f: # Opens repo file
		repoContents = f.read()

	print("Compiling regexes")
	packages = re.compile(r"(([^file]|^)name?\s=?\s.*)") # Gets all package names.

	versions = re.findall(re.compile(r"(version?\s=?\s.*)"), repoContents) # Gets all package versions.
	frmlinks = re.findall(re.compile(r"(--link?\s=?\s.*)"), repoContents) # Gets package links.

	print("Parsing repository file")
	cnt = 0
	readme_packages = ""
	for package in re.findall(packages, repoContents): # This was worse before, trust me.
		try:
			readme_packages = readme_packages + "* [" + package[0].split("=")[1].strip() + "](" + frmlinks[cnt].split("=")[1].strip() + ") " + versions[cnt].split("=")[1].strip() + "\n"
			cnt += 1
		except IndexError as ie:
			print("""
You either forgot to version your package, or forgot a link for it.
You can add a link by creating a \"--link\" key before \"end\"

Example:
	dependencies = none
	--link = https://computercraft.info/forums2/MYCOOLPACKAGE-thread

IndexError: """ + str(ie))
			return 1
	cnt = None

	print("Saving")
	with open("README.md", "w") as f: # Opens repo file
		f.write(readme_header)
		f.write(readme_packages + "\n")
		f.write(readme_footer)

	print("Done!")
	return 0

if __name__ == '__main__':
	exit(main())
