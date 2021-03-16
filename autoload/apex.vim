if exists("g:isCsfApexLoaded")
	finish
endif

let g:isCsfApexLoaded=1 

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

" TODO: when this function will be generic it should be move to a common file
" instead of the apex
function! apex#CsfDeployCurrentBuffer()
	let current_buffer_extension=expand('%:e')

    if current_buffer_extension != "cls"
        echoerr "Unsupported type. Currently only APEX is supported"
        return
    endif

	let current_buffer=expand('%:t:r')

    execute "!sfdx force:source:deploy -u default -m ApexClass:" . current_buffer
    echo "Deployed source: " . current_buffer
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

    execute "!sfdx force:apex:class:create -n " . className . " -d " . directory

    echo "Class \"" . className . "\" created on the directory \"" . directory . "\""
endfunction
