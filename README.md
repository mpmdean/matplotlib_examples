# matplot_examples
This package contains a matplotlibrc file for saving matplotlib configuration and examples of how to create attractive plots.

## Notes
* The width of a figure should always be set to the real physical column width. e.g. 3+3/8 inches for a PRL column. This will mean that fonts appear on the page in the correct size.

* Using a uniform style is very important for an attractive manuscript. Try to avoid ad-hoc changes to the settings. If you feel that there is a desirable change, consider applying it to the whole manuscript, preferably by setting some edits to the matplotlibrc file in the working folder or right at the start of the script/notebook. e.g. mpl.rc('font', size=10).

* Gridspec and subplots_adjust are useful to set the precise location of panels.

* Including 2-4 minor ticks per major tick is usually good.

* Putting the colorbar on separate axes facilities better control over its location.

* Saving in pdf creates vector graphics and fast performance within pdflatex.


## To run
Run a mybinder sessesion [here](https://mybinder.org/v2/gh/mpmdean/matplotlib_examples/master?filepath=ex_01_multipanel_colorplot.ipynb).

chmod +x copy_to_matplotlibrc_folder
./copy_to_matplotlibrc_folder

To copy file to the place in which matplotlib checks. 

run locally via installing [docker](https://www.docker.com/)  

`pip install jupyter-repo2docker` 
and then pointing to an appropriate docker image 
`jupyter-repo2docker --editable .` 


