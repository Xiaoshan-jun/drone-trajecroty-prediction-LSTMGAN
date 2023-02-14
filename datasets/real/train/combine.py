# -*- coding: utf-8 -*-
"""
Created on Tue Feb 14 15:09:45 2023

@author: dekom
"""
import os

# Get the current directory
directory = os.getcwd()

# Get a list of all .txt files in the directory
txt_files = [f for f in os.listdir(directory) if f.endswith('.txt')]

# Open a new file for writing
with open("combined_file.txt", "w") as outfile:
    # Loop through each .txt file and write its contents to the new file
    for file in txt_files:
        with open(file, "r") as infile:
            outfile.write(infile.read())