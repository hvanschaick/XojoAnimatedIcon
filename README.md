# XojoAnimatedIcon
Small Xojo Class based on Canvas control for displaying an animated ICON

Animates the graphics stored in the named subdirectory by replacing the images after a timer has lapsed.
Just drag the subclassed canvas on the windows or container.
Call the initialize method to configure the contents. 

Initialize(dirname as string, Interval as integer = 50, stdIcon as Picture = nil) As Boolean

The methods startAnimation and stopAnimation control the animation. Interval is the speed in mS.
stdIcon is the Icon that will be displayed if there is no animation. 
If stdIcon is "nil" than the backdrop will be applied, if that is defined.

Issues: 
In a built app the directories containing the images should be located in the Resource directory. 
Be sure to copy these files there after a build. 
The icons are scaled for every display. This could be improved by scaling the images during initialisation.

For comments or suggestions: hvanschaick [at] ast-software.nl
