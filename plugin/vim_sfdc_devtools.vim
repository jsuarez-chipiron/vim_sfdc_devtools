if exists("g:isPluginLoaded")
	finish
endif
let g:isPluginFtLoaded=1 

" Command declarations {{{
command! -range   CsfQueryRange <line1>,<line2>call tolls#CsfQueryRangeInternal()
command! -nargs=1 CsfQuery call tolls#CsfQueryCmd(<f-args>)
command! -range   CsfAnonymous <line1>,<line2>call tolls#CsfAnonymousInternal()
command!  CsfApexPmdCurrentProject call apex#ApexPMDCurrentProject()
"}}}
