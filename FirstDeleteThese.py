# Python Script for Blender Aorta CFD project
# Written by Charles Jenkinson
# Last updated 14/08/2020

# Run this script when a new Blender instance
# is opened to delete default objects
# namely the camera, cube, and light.

import bpy


# Select objects for deletion (camera, cube, light)
objs = [bpy.context.scene.objects['Camera'],
    bpy.context.scene.objects['Cube'],
    bpy.context.scene.objects['Light']
    ]

# Delete the objects previously selected
bpy.ops.object.delete({"selected_objects": objs})
