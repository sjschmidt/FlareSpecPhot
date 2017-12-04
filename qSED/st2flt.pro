;SJS August 2007

;accepts an array of string spectral types. converts K0 to T9 into
;-10 to 29. Passes the array back. anything unrecognized gets -99.

;SJS oct 2007 - turned into a function.

FUNCTION ST2FLT,st_str

if n_params() lt 1 then begin
    print,'Syntax - st2flt(st_string)'
    return,0
endif

max=n_elements(st_str)
st_flt=fltarr(max)

st_str=strtrim(st_str,1)

for i = 0L,max-1 do begin

   st_str[i] = (strsplit(st_str[i],'VI',/extract))[0]

    if strpos(st_str[i],'s') eq 0 then begin
        st_flt[i] = 50.

    endif else if strpos(st_str[i],'O') eq 0 then begin
        st_flt[i] = -60. + float(strsplit(st_str[i],'O',/extract))
        
    endif else if strpos(st_str[i],'B') eq 0 then begin
        st_flt[i] = -50. + float(strsplit(st_str[i],'B',/extract))
        
    endif else if strpos(st_str[i],'A') eq 0 then begin
        st_flt[i] = -40. + float(strsplit(st_str[i],'A',/extract))
        
    endif else if strpos(st_str[i],'F') eq 0 then begin
        st_flt[i] = -30. + float(strsplit(st_str[i],'F',/extract))
        
    endif else if strpos(st_str[i],'G') eq 0 then begin
        st_flt[i] = -20. + float(strsplit(st_str[i],'G',/extract))
        
    endif else if strpos(st_str[i],'K') eq 0 then begin
        st_flt[i] = -10. + float(strsplit(st_str[i],'K',/extract))
        
    endif else if strpos(st_str[i],'M') eq 0 then begin
        st_flt[i] = float(strsplit(st_str[i],'M',/extract))

    endif else if strpos(st_str[i],'L') eq 0 then begin
        st_flt[i] = 10. + float(strsplit(st_str[i],'L',/extract))

    endif else if strpos(st_str[i],'T') eq 0 then begin
        st_flt[i] = 20. + float(strsplit(st_str[i],'T',/extract))

    endif else st_flt[i] = -99.

endfor

return,st_flt

END

