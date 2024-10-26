#! /bin/bash
echo
echo '********************************'
echo '*            BTOFS             *'
echo '*  Blender to OpenFoam Script  *'
echo '* Written by Charles Jenkinson *'
echo '*   Last updated 29-08-2020    *'
echo '********************************'
echo

# Take system date and print
now=$(date)
echo "BTOFS was run on: $now"
echo #Newline

# Remove all instances of the current version of Blender from the STL file (which is 2.83.4 on 14/08/2020)
gsed -i "" -e "s/Exported from Blender-2.83.4//g" *
echo 'Removed Exported from Blender-<version> tag'
echo #New line

# This next section replaces the first line with 'solid <filename>.stl' for all the mesh files.
# It would have to be done manually if there were non-conventional branching of the aorta.
# gsed is used as it plays nicer with OSX, which was causing errors when using SED.
# gsed can be obtained by typing brew install gnu-sed into the terminal.
#######################################
var="solid AortaWall"
gsed -i "1s/.*/$var/" AortaWall.stl
echo 'Changed first line of AortaWall.stl'

var="solid AortaInlet"
gsed -i "1s/.*/$var/" AortaInlet.stl
echo 'Changed first line of AortaInlet.stl'

var="solid AortaOutlet"
gsed -i "1s/.*/$var/" AortaOutlet.stl
echo 'Changed first line of AortaOutlet.stl'

var="solid BCA"
gsed -i "1s/.*/$var/" BCA.stl
echo 'Changed first line of BCA.stl'

var="solid LCCA"
gsed -i "1s/.*/$var/" LCCA.stl
echo 'Changed first line of LCCA.stl'

var="solid LSCA"
gsed -i "1s/.*/$var/" LSCA.stl
echo 'Changed first line of LSCA.stl'
echo #New line
#######################################

# Removes the endsolid tag from the final line of each STL file, which allows it to be reinserted followed by the filename.
# This has one unintended consequence - a blank line is added between the STL data and the 'endsolid <filename>.STL' however this does not seem to cause any issues.
# In a future update, this may be replaced by gsed, but this script works on OSX for now.
gsed -i "" -e "s/endsolid//g" *
echo 'All file instances of endsolid removed.'

# Adds endsolid <filename.stl> to each of the mesh STL files
#######################################
echo 'endsolid AortaWall' >> AortaWall.stl
echo 'Added endsolid <filename> to AortaWall.stl'

echo 'endsolid AortaInlet' >> AortaInlet.stl
echo 'Added endsolid <filename> to AortaInlet.stl'

echo 'endsolid AortaOutlet' >> AortaOutlet.stl
echo 'Added endsolid <filename> to AortaOutlet.stl'

echo 'endsolid BCA' >> BCA.stl
echo 'Added endsolid <filename> to BCA.stl'

echo 'endsolid LCCA' >> LCCA.stl
echo 'Added endsolid <filename> to LCCA.stl'

echo 'endsolid LSCA' >> LSCA.stl
echo 'Added endsolid <filename> to LSCA.stl'
#######################################

echo
echo 'Thank you for using BTOFS.'
Echo
