if exists("g:isCsfFtApexLoaded")
	finish
endif
let g:isCsfFtApexLoaded=1 
augroup apexgroup 
	autocmd!
	autocmd BufWritePost <buffer> call apex#ApexPMDBuffer()
augroup END
