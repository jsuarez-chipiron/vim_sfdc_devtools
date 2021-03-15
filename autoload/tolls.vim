
if exists("g:isToolsLoaded")
	finish
endif
let g:isToolsLoaded = 1
"SOQL{{{
function! tolls#CsfQuery(query)
    echo "Running Query..."
    let query = substitute(a:query, "!", "\\\\!", "g")
    silent execute "read !sfdx force:data:soql:query -q \"" . query . "\" -u default"
    execute "normal ?Querying Data\<CR>"
    normal dd
    execute "normal ?Total number\<CR>"
    normal "udd
    call timer_start(50, {-> execute("call tolls#PrintCsfQueryResult()", "")})
endfunction

function! tolls#CsfQueryCmd(query)
    normal G
    call tolls#CsfQuery(a:query)
endfunction

function! tolls#PrintCsfQueryResult()
    echo getreg("u")
endfunction

function! tolls#CsfQueryRangeInternal() range
    let i = a:firstline
    let val = ""
    while i <= a:lastline
        let val .= getline(i)
        let i += 1
    endwhile

    call tolls#CsfQuery(val)

endfunction
"}}}
"Anonymus {{{
function! tolls#CsfAnonymousInternal() range
    let tempFileName = tempname()
    echo "Executing Apex Anonymous..."
    call writefile(getline(a:firstline, a:lastline), tempFileName)
    silent execute "read !sfdx force:apex:execute -u default -f " . tempFileName
endfunction
"}}}
