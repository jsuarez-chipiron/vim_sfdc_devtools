if exists("g:isCsfAuthLoaded")
	finish
endif
let g:isCsfAuthLoaded = 1

function! auth#CsfLogin(domain)
    silent execute "!sfdx force:auth:web:login -r " .a:domain. " -s -a default"
endfunction

function! auth#CsfLogout()
    silent execute "!sfdx auth:logout -u default"
endfunction

function! auth#CsfGetUsername()
    let tempFileName = tempname()
    echo "Waiting for authentication..."
    silent execute "!sfdx force:org:list | grep default | awk '{print $3}' > " .tempFileName
    let file = readfile(tempFileName)
    return file[0]
endfunction

