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
    echo "Waiting for authentication..."
    let res = system("sfdx force:org:list | grep default | awk '{print $3}'")

	if v:shell_error ==# "0"
        echo res
	else
		echom "Error 😱: Authenticating user"
	endif
endfunction

