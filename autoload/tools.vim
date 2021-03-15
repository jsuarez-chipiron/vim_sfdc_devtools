
if exists("g:isCsfToolsLoaded")
	finish
endif
let g:isCsfToolsLoaded = 1
"SOQL{{{
function! tools#CsfQuery(query)
    echo "Running Query..."
    let query = substitute(a:query, "!", "\\\\!", "g")
    silent execute "read !sfdx force:data:soql:query -q \"" . query . "\" -u default"
    execute "normal ?Querying Data\<CR>"
    normal dd
    execute "normal ?Total number\<CR>"
    normal "udd
    call timer_start(50, {-> execute("call tools#PrintCsfQueryResult()", "")})
endfunction

function! tools#CsfQueryCmd(query)
    normal G
    call tools#CsfQuery(a:query)
endfunction

function! tools#PrintCsfQueryResult()
    echo getreg("u")
endfunction

function! tools#CsfQueryRangeInternal() range
    let i = a:firstline
    let val = ""
    while i <= a:lastline
        let val .= getline(i)
        let i += 1
    endwhile

    call tools#CsfQuery(val)

endfunction
"}}}
"Anonymus {{{
function! tools#CsfAnonymousInternal() range
    let tempFileName = tempname()
    echo "Executing Apex Anonymous..."
    call writefile(getline(a:firstline, a:lastline), tempFileName)
    silent execute "read !sfdx force:apex:execute -u default -f " . tempFileName
endfunction
"}}}
