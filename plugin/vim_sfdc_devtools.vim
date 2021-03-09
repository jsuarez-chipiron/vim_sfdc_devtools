" Function declarations

function! ApexPMDInternal(path)

    let current_path = a:path
    let pmd_home = g:pmd_home
    let ruleset_path = g:ruleset_path
    let current_cmd = pmd_home . "/bin/run.sh pmd -d " . current_path . " -rulesets " . ruleset_path . " -language apex 2> /dev/null"

    " cexpr system(current_cmd) " en vez de cexpr que salta a la primera linea
    " se usa el siguiente comando
    cgetexpr system(current_cmd)

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

function! CsfQuery(query)
    normal G
    silent execute "read !sfdx force:data:soql:query -q '" . a:query . "'"
    execute "normal ?Querying Data\<CR>"
    normal dd
    execute "normal ?Total number\<CR>"
    normal "udd
    call timer_start(50, {-> execute("call PrintCsfQueryResult()", "")})
endfunction

function! PrintCsfQueryResult()
    echo getreg("u")
endfunction

function! CsfQueryRangeInternal() range
    let i = a:firstline
    let val = ""
    while i <= a:lastline
        let val .= getline(i)
        let i += 1
    endwhile

    call CsfQuery(val)

endfunction

" Command declarations
command! -range CsfQueryRange <line1>,<line2>call CsfQueryRangeInternal()
command! -nargs=1  CsfQuery  call CsfQuery(<f-args>)

autocmd BufWritePost *.cls call ApexPMDBuffer()

