;sjs 4 Dec 2017 

;called by makeSED, this function reads in the spectroscopic data,
;normalizes to i magnitude at 10 pc, and interpolates to the input
;wavelength array.

;updated 16 July 2019 to also make an error array! 

function getspec,wave,s,fname,ifp,rad,te

     ;putting together the spectrum
  spec = readt(s)               ;optical read in 
  wo = reform(spec[*,0])
  fo = reform(spec[*,1])
  eo = reform(spec[*,2])
  
  readcol,'i.dat',iwav,ires,f='(d,d)',/silent ;get the i filter curve
  ires = ires/tsum(iwav,ires)
  
  intfluxi = interpol(fo,wo,iwav) ;calibrate optical to i band abs mag
  iflux_spec = tsum(iwav,intfluxi*ires)
  
  fo = fo*ifp/iflux_spec
  eo = eo*ifp/iflux_spec
;  fo = smooth(fo,20/abs(wo[1]-wo[0])) ;smooth to reduce noise
  
  readcol,reform(fname),wi,fi,ei,/silent ;read in IR
  wi = wi*10000
  norm = mean(fo[where(wo gt 7700 and wo lt max(wo))])/$ ;norm IR to optical
         mean(fi[where(wi gt 7700 and wi lt max(wo))])
  fi = fi*norm
  ei = ei*norm
  
  fi = fi[where(wi gt max(wo))] ;truncate IR to where optical ends
  ei = ei[where(wi gt max(wo))]
  wi = wi[where(wi gt max(wo))]
  
  w0 = findgen(min(wo)-min(wave))+min(wave) ;repace blueward of data with BB
  dist = 10*3.0857e18     
  f0 = 0.5*!dpi*bbspec(w0,te)*(rad/dist)^2.
  e0 = fltarr(n_elements(w0))
  
  flux = interpol([f0,fo,fi],[w0,wo,wi],wave) ;flux is in ergs/cm^2/s/A
  error = interpol([e0,eo,ei],[w0,wo,wi],wave) ;error is in ergs/cm^2/s/A

  return,[[flux],[error]]
  
end
