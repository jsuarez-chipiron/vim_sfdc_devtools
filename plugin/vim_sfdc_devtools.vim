if exists("g:isCsfPluginLoaded")
	finish
endif
let g:isCsfPluginFtLoaded=1 

" Command declarations {{{
command! -range   CsfQueryRange <line1>,<line2>call tools#CsfQueryRangeInternal()
command! -nargs=1 CsfQuery call tools#CsfQueryCmd(<f-args>)
command! -range   CsfAnonymous <line1>,<line2>call tools#CsfAnonymousInternal()
command!  CsfLoginProd call auth#CsfLogin("https://login.salesforce.com")
command!  CsfLoginSandbox call auth#CsfLogin("https://test.salesforce.com")
command!  CsfLogout call auth#CsfLogout()
command!  CsfShowUsername call auth#CsfGetUsername()
command!  CsfCreateApexClass call apex#CsfCreateApexClass()
command!  CsfDeployCurrentBuffer call apex#CsfDeployCurrentBuffer()
command!  CsfApexDiff call apex#CsfApexDiff()
"}}}
