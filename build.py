import os
import shutil
import subprocess
import sys

gitDir = os.path.dirname(os.path.realpath(__file__))
addonsDir = gitDir + "\\addons"
mainDir = addonsDir + "\\suppression"

print("gitDir:    " + gitDir)
print("addonsDir: " + addonsDir)
print("mainDir:   " + mainDir)

def getVersion():
    print ("Set version number:")
    major = input("Major: ")
    minor = input("Minor: ")
    patch = input("Patch: ")
    print ("Version: {}.{}.{}".format(major,minor,patch))
    return(major, minor, patch)

def updateVersion(version):
    global tempDir
    major, minor, patch = version

    with open(mainDir + "\\script_version.hpp", "r") as file:
        lines = file.readlines()
        lines[0] = "#define MAJOR " + major + "\n"
        lines[1] = "#define MINOR " + minor + "\n"
        lines[2] = "#define PATCHLVL " + patch + "\n"
        build = str(int(lines[3][14:]) + 1)
        print("Build: " + build)
        lines[3] = "#define BUILD " + build + "\n"
    with open(mainDir + "\\script_version.hpp", "w") as file:
        for line in lines:
            file.write(line)

    return(major,minor,patch,build)

def pack(version):
    major, minor, patch, build = version
    strVersion = "{}.{}.{}.{}".format(major,minor,patch,build)
    destDir = gitDir + "\\releases\\" + strVersion + "\\"
    if not os.path.exists(destDir):
        os.makedirs(destDir)
    source = mainDir
    target = gitDir + "\\releases\\" + strVersion + "\\xru_suppression.pbo"
    subprocess.run(["armake_w64.exe","build","-f","-i","P:",source,target], stdout = subprocess.PIPE)

version = updateVersion(getVersion())
pack(version)

print("Done!")
input('Press Enter to exit')
