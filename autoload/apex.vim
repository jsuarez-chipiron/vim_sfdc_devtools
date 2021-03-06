if exists("g:isApexLoaded")
	finish
endif
let g:isApexLoaded=1 
function! apex#ApexPMDInternal(path)

    let current_path = a:path
    let pmd_home = g:pmd_home
    let ruleset_path = g:ruleset_path
    let current_cmd = pmd_home . "/bin/run.sh pmd -d " . current_path . " -rulesets " . ruleset_path . " -language apex 2> /dev/null"

    " cexpr system(current_cmd) " en vez de cexpr que salta a la primera linea
    " se usa el siguiente comando
    cgetexpr system(current_cmd)

    copen

endfunction
function! apex#ApexPMDBuffer()
	let current_buffer=expand('%')
	call apex#ApexPMDInternal(current_buffer)
endfunction
function! apex#ApexPMDCurrentProject()
    let current_project = getcwd()
    call apex#ApexPMDInternal(current_project)
endfunction
