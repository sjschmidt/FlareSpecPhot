;sjs dec 13 2011

;read in the correct template spectrum in a unified format given the
;spectral type in either number or letter format.

function readt,spect

  test = size(spect)
  num = valid_num(spect)
  if test[1] eq 7 and num eq 0 then $
     spectn = floor(st2flt(strupcase(spect))) else $
        spectn = floor(1.0*spect)

  if spectn ge 10 then dir = 'S14L/'
  if spectn lt 7 then dir = 'B07M/'
  if spectn ge 7 and spectn lt 10 then dir = 'S18M/'

  if spectn lt 7 and spectn ge 0 then begin
     dat = $
        readfits(dir + 'm' + strtrim(spectn,2) + '.all.na.k.fits',head,/silent)
     wave = sxpar(head,'crval1') + $
            dindgen(sxpar(head,'naxis1'))*sxpar(head,'cd1_1')
     vactoair,wave

     return,[[wave],[dat[*,1]],[dat[*,2]]]

  endif 

  if spectn ge 7 and spectn lt 19 then begin

     dat = readfits(dir + flt2st(spectn) + '.fits',head,/silent)

     wave = 10^(sxpar(head,'crval1') + $
            dindgen(sxpar(head,'naxis1'))*sxpar(head,'cdelt1'))
 
     return,[[wave],[dat[*,1]],[dat[*,2]]]

  endif
 
end
