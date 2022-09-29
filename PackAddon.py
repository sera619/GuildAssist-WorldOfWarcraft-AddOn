import os
import shutil
from dotenv import load_dotenv

load_dotenv('.env')


addon_path = str(os.getenv('ADDON_PATH'))
package_path = str(os.getenv('PACKAGE_PATH'))

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

    dirname = "GuildAssist3"
    os.mkdir(package_path+dirname)

    numFiles = 0
    for file in files:
        print("Copy file: " + file + "... ")
        filepath = addon_path + file
        shutil.copy(filepath, package_path+dirname,  follow_symlinks=True) 
        numFiles += 1
    print(numFiles, " file[s] successfully copied!")
    
    numFolders = 0
    for folder in folders:
        print("Copy directory: " + folder + "...")
        folderpath = addon_path+"\\"+folder+"\\"
        shutil.copytree(folderpath, package_path+dirname+"\\"+folder)
        numFolders += 1
    print(numFolders," directory[s] successfully copied!")

    print("Create zip file ...")
    zipfile = shutil.make_archive(dirname+"_"+version, "zip", root_dir= package_path+dirname)
    print("Move Zip to packages ...")
    shutil.move(zipfile, package_path)
    print("Delete temp packaging directory ...")
    shutil.rmtree(package_path+dirname)
    print("GuildAssist3_"+version+".zip succesfully created!")
    exit(0)

def main():
    packageAddon()

if __name__ == '__main__':
    main()