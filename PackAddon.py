import os
import shutil
from dotenv import load_dotenv

load_dotenv('.env')


addon_path = str(os.getenv('ADDON_PATH'))
package_path = str(os.getenv('PACKAGE_PATH'))
package_holder_path = str(os.getenv('PACKAGE_HOLDER_PATH'))

def createFolder():
    if os.path.exists(package_holder_path):
        shutil.rmtree(package_holder_path)
    os.makedirs(package_path)


def packageAddon():
    if not package_path:
        return print("no path")

    files = ["embeds.xml", "tables.lua", "UI_Templates.lua", "Core.lua", "config.lua", "GuildAssist3.toc", "README.md"]
    folders = ["Libs", "img"]
    os.system("cls")
    print("\nGuildAssist3 Addon Builder\n")
    version = input("Enter new Version: ")
    if version == "" or version == None:
        print("Please enter a version")
        return packageAddon()

    createFolder()
    
    numFiles = 0
    for file in files:
        print("Copy file: " + file + "... ")
        filepath = addon_path + file
        shutil.copy(filepath, package_path,  follow_symlinks=True) 
        numFiles += 1
    print(numFiles, " file[s] successfully copied!")
    
    numFolders = 0
    for folder in folders:
        print("Copy directory: " + folder + "...")
        folderpath = addon_path+"\\"+folder+"\\"
        shutil.copytree(folderpath, package_path+"\\"+folder)
        numFolders += 1
    print(numFolders," directory[s] successfully copied!")

    old_path = package_holder_path
    print("Create zip file ...")
    zipfile = shutil.make_archive("GuildAssist3_"+version, "zip", root_dir= package_holder_path)
    print("Move Zip to packages ...")
    shutil.move(zipfile, addon_path+"\\packages")
    
    print("Delete temp packaging directory ...")
    shutil.rmtree(old_path)
    print("\nGuildAssist3_"+version+".zip succesfully created!")

    exit(0)

def main():
    packageAddon()
    #createFolder()


if __name__ == '__main__':
    main()