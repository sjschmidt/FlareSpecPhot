;sjs 4 Dec 2017

;organized version of SED constructing code
;reads in a combination of SDSS template spectra and PRISM library
;spectra to make an SED calibrated to SDSS photometry at 10 PC

;calls getspec.pro


pro makeSED,plot=plot

;first, establish absoute i flux per spectral type 
;use i mag @ 10pc, but convert from r for M's and j for late-L's
  r10p = [7.6,8.4,9.6,10.5,11.3,12.7,14,14.8,16.3,17.4];m0-m9
  ri = [0.56,0.73,0.96,1.13,1.33,1.62,1.92,2.09,2.56,2.70]
  j10p = [13.71,13.99,14.19]
  ij = [5.15,5.29,5.48]
  i10p = [r10p-ri,15.8,16.4,16.9,17.4,18.2,18.8,j10p+ij];m0-L8
;used Schmidt2010,Bochanski2010,Cruz2003 for abs mags
;used Schmidt2010,West2011,Schmidt2015 for colors
;have tweaked some values for smooth distribution

;convert i magnitude to flux
  convjan = 2.99792458e-05 
  const_i = 1.8d-10 
  centw_i = 7600.0
  iflux_phot = 3631*2*const_i*sinh(-1*alog(const_i) - $ ;i flux from phot
                                   (alog(10)/2.5)*i10p)*convjan/(centw_i)^2.

;need Teff to fill in blue spectrum
;Teff FLD 6.0<SpT<29.0 113K (filipazo2015 for field dwarfs)
  a = [4.747e+03,-7.005e+02,1.155e+02,-1.191e+01,6.318e-01,-1.606e-02,1.546e-04]
  x = findgen(20)
  teff = fltarr(20)
  for i = 0,6 do teff = teff+a[i]*x^i

;Teff based on my own fit to the data in Mann2015, used for M0-M5
  teff_mann = 3856.03-106.171*x-16.1756*x^2+1.14145*x^3
  teff[0:5] = teff_mann[0:5]

;radius also needed, forget my refs for this section, will go back...
  radius = [0.62,0.49,0.44,0.39,0.36,0.2,0.15,0.12,0.11,0.09,0.08,0.08,0.08,0.08,0.08,0.08,0.08,0.08,0.08,0.08]*6.9599e10

  nspec = n_elements(i10p)
  readcol,'prism.txt',st,fname,f='(a,a)',/silent ;refs in proceedings draft

  w = findgen(900)*10+3000.0D

  if keyword_set(plot) then begin
     !p.font=0 
     !p.thick=3
     !x.thick=3
     !y.thick=3
     loadct,39,/silent
     
     set_plot,'ps'
     device,filename='SED.eps',helvetica=1,xsize=10,$
            isolatin=1,ysize=7.5,/inches,xoffset=.5,$
            yoffset=.5,encapsulated=1,/color
     
     plot,[3000,12000],[1e-20,1e-11],/nodata,xstyle=1,ystyle=1,/ylog,$
          xtitle='Wavelength (A)',ytitle='Flux (erg cm!E-2!N s!E-1!N A!E-1!N)',$
          xtickformat='(i)'
  endif
  
  for i = 0,18 do begin
     
     res = getspec(w,i,'prism/'+fname[where(i eq st2flt(st))],iflux_phot[i],$
                 radius[i],teff[i])
     f = res[*,0]
     e = res[*,1]

     openw,outf,'txt/' + flt2st(i) + '_SED.txt',/get_lun
     for k = 0,n_elements(w)-1 do printf,outf,w[k],f[k],e[k]
     free_lun,outf

     if keyword_set(plot) then oplot,w,f,color=230-i*10  
     if keyword_set(plot) then $
        xyouts,10000,10^(-16-0.2*i),flt2st(i),color=230-i*10
  endfor
  
  if keyword_set(plot) then begin
     device,/close
     set_plot,'x'
  endif

end
