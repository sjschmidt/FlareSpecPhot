;sjs 4 Dec 2017

;function to generate a thermal spectrum given a wavelength and T

function bbspec,wav,t

  ;wv in angstroms
  h = 6.62607e-27 ;erg * s
  c = 2.99792e10 ;cm/s
  k = 1.380658e-16 ;erg/K
  a2c = 1e-8

  return,((2*h*c^2)/((wav^5.)*(a2c^4.)))/(exp((h*c)/(wav*(1e-8)*k*t))-1)

end
