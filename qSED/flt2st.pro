;SJS August 2007
;Converts spectral types in floats to strings

;types -10 to 29 go to K0 to T9

;SJS Oct 2007 turned into function

FUNCTION FLT2ST,st_flt,latex=latex

if n_params() lt 1 then begin
    print,'Syntax - flt2st(st_float)'
    return,0
endif

max = n_elements(st_flt)
st_str = strarr(max)

;then, trim of 0's and possible decimal points before 0's. then add
;M,L, etc.

for i= 0,max-1 do begin

    if st_flt[i] eq floor(st_flt[i]) then blah = -1 else blah = 1

    if st_flt[i] ge 20 then begin
        st_str[i] = 'T'+ strmid(strtrim(st_flt[i] - 20,1),0,2+blah)

    endif else if st_flt[i] ge 10 then begin
        st_str[i] = 'L' + strmid(strtrim(st_flt[i] - 10,1),0,2+blah)

    endif else if st_flt[i] ge 0 then begin
        st_str[i] = 'M' + strmid(strtrim(st_flt[i],1),0,2+blah)

    endif else if st_flt[i] ge -10 then begin
        st_str[i] = 'K' + strmid(strtrim(st_flt[i] + 10,1),0,2+blah)

    endif else st_str[i] = 'Other'
    
    if st_str[i] eq 'Other' and keyword_set(latex) then st_str[i] = '\nodata'

endfor

return,st_str

END


