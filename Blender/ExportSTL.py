ExportSTL.py - Python script to export all components of mesh as separate STL files

# Python Script for Blender Aorta CFD project
# This script outputs all mesh STLs into a specified folder
# with correct dimensioning and formatting

# Written/Adapted by Charles Jenkinson
# Reference to borrowed code provided below
# Last updated 14/08/2020

import bpy
from pathlib import Path

#Set location of items to be exported
context = bpy.context
scene = context.scene
viewlayer = context.view_layer

# Creating a list of all meshes
obs = [o for o in scene.objects if o.type == 'MESH']
bpy.ops.object.select_all(action = 'DESELECT')

# Set path of folder in which to export each mesh
path = Path("/Users/charlesjenkinson/Desktop/BlenderOutput")

# Creates loop to export each mesh
for ob in obs:
    viewlayer.objects.active = ob
    ob.select_set(True)
    stl_path = path / f"{ob.name}.stl" # set filename as <mesh name>.stl in folder specified above
    bpy.ops.export_mesh.stl(           # exports each mesh with the following parameters:
            filepath = str(stl_path),  # sets location to save file
            check_existing = True,     # Checks for existing files (seems to not do anything)
            use_scene_unit = True,     # Keeps the units set in the scene. We are using metres
            ascii = True,              # Sets output to ASCII. Otherwise binary file, which cannot be read by openFoam.
            use_selection = True)      # Ensures that selected objects (as above) are exported
    ob.select_set(False)

# Adapted from user https://blender.stackexchange.com/users/15543/batfinger
# from code on https://blender.stackexchange.com/questions/130841/exporting-only-1-object-at-a-time-to-stl-using-blender-script-python
# Further information https://docs.blender.org/api/current/bpy.ops.export_mesh.html
