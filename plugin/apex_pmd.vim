function! ApexPMDInternal(path)

    let current_path = a:path
    let pmd_home = g:pmd_home
    let ruleset_path = g:ruleset_path
    let current_cmd = pmd_home . "/bin/run.sh pmd -d " . current_path . " -rulesets " . ruleset_path . " -language apex"

    " cexpr system(current_cmd) " en vez de cexpr que salta a la primera linea
    " se usa el siguiente comando
    cgetexpr system(current_cmd)

    " TODO: remove two first lines from the quickfix list
    copen

endfunction

function! ApexPMDBuffer()

    let current_buffer=expand('%')
    call ApexPMDInternal(current_buffer)

endfunction

function! ApexPMDCurrentProject()

    let current_project = getcwd()
    call ApexPMDInternal(current_project)

endfunction

autocmd BufWritePost *.cls call ApexPMDBuffer()

let g:pmd_home=''
let g:ruleset_path=''
