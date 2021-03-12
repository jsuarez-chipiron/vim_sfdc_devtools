if exists("g:isFtApexLoaded")
	finish
endif
let g:isFtApexLoaded=1 
augroup apexgroup 
	autocmd!
	autocmd BufWritePost <buffer> call apex#ApexPMDBuffer()
augroup END
