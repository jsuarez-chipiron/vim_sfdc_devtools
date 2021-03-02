function! ApexPMD()
    let current_buffer=expand('%')
    let pmd_home = g:pmd_home
    let ruleset_path = g:ruleset_path
    let current_cmd = pmd_home . "/bin/run.sh pmd -d " . current_buffer . " -rulesets " . ruleset_path . " -language apex"

    " cexpr system(current_cmd) " en vez de cexpr que salta a la primera linea
    " se usa el siguiente comando
    cgetexpr system(current_cmd)

    " TODO: remove two first lines from the quickfix list
    copen

endfunction

autocmd BufWritePost *.cls call ApexPMD()

let g:pmd_home=''
let g:ruleset_path=''
