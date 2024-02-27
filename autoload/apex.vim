if exists("g:isCsfApexLoaded")
	finish
endif

let g:isCsfApexLoaded=1 
"Used to add sfdx deploy errors to quicktext
set efm+=%.%#Error\ \ %f\ \ %m(%l:%.%#

function! apex#ApexPMDInternal(path)

    let current_path = a:path
    let pmd_home = g:pmd_home
    let ruleset_path = g:ruleset_path
    let current_cmd = pmd_home . '/bin/pmd check --dir=' . current_path . ' --rulesets=' . ruleset_path . ' --use-version=apex-57 2> /dev/null'

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

" TODO: when this function will be generic it should be move to a common file
" instead of the apex
function! apex#CsfDeployCurrentBuffer()
	let current_buffer_extension=expand('%:e')

	if current_buffer_extension != "cls"
		echoerr "Unsupported type. Currently only APEX is supported"
		return
	endif

	let current_buffer=expand('%:t:r')

	echom "Deploying source 🙏: " . current_buffer
	let current_cmd = "sfdx force:source:deploy -u default -m ApexClass:" . current_buffer . " 2>/dev/null"
	let res= system(current_cmd) 
	if v:shell_error ==# "0"
		echom "Deployed source 😎: " . current_buffer
	else
		cgetexpr filter(split(res,"\n"), "v:val =~ 'Error'") 
		copen
		echom "Error 😱: " . current_buffer
	endif
endfunction

function! apex#CsfCreateApexClass()
    let directory = "force-app/main/default/classes/"
    call inputsave()
    let className = input('Enter class name: ')
    call inputrestore()
    echo "\nDo you want to create the class in the directory \"force-app/main/default/classes/\"?"
    call inputsave()
    let flag = input('(y/n): ')
    call inputrestore()
    if flag == "n"
        call inputsave()
        let directory = input('Enter the directory path: ')
        call inputrestore()
    endif

    let cmd = "sfdx force:apex:class:create -n " . className . " -d " . directory

    let ret = system(cmd)

	if v:shell_error ==# "0"
        echo "\nClass \"" . className . "\" created on the directory \"" . directory . "\""
	else
		echom "Error 😱: Authenticating user"
	endif

endfunction

function! apex#CsfApexDiff() range

	let current_buffer_extension=expand('%:e')

	if current_buffer_extension != "cls"
		echoerr "Unsupported type. Currently only APEX is supported"
		return
	endif

	let current_buffer=expand('%:t:r')
    let tempFileName = tempname()

    call writefile(getline(1, '$'), tempFileName)

	let current_cmd = "sfdx force:source:retrieve -u default -m ApexClass:" . current_buffer . " 2>/dev/null"
    echom "Retrieving source: " . current_buffer . " for comparation"
    
	let res= system(current_cmd) 
	if v:shell_error ==# "0"
        silent execute "edit"
        silent execute "vertical diffsplit " . tempFileName
	else
		echom "Error 😱: Comparing " . current_buffer
	endif


endfunction

