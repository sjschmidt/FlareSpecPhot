# Notes on Quiescent SEDs

The final SEDs are in the txt/ directory - they are text files with wavelength (A) in the first column, flux for a dwarf located at 10 pc from the Sun (ergs/cm^2/s/A) in the second column, and error for that dwarf (same units) in the third column. The errors are non-homogeneously determined, they are 0 for the bluest wavelengths, based on the standard deviation of many spectra for the optical templates, and from the prism spectra for the infrared.

The wrapper program is getSED.pro, and getspec.pro is where the spectra are normalized and interpolated. 

Details on the optical templates used:
- B07M/ M0-M6 Bochanski et al. 2007
- S18M/ M7-M9 Schmidt et al. 2018, in prep. 
- S14L/ L0-L8 Schmidt et al. 2014a

Details for the IR spectra are in prism.txt and within the files themselves. 
