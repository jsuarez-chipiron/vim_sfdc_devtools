if exists("g:isPluginLoaded")
	finish
endif
let g:isPluginFtLoaded=1 

" Command declarations {{{
command! -range   CsfQueryRange <line1>,<line2>call tolls#CsfQueryRangeInternal()
command! -nargs=1 CsfQuery call tolls#CsfQueryCmd(<f-args>)
command! -range   CsfAnonymous <line1>,<line2>call tolls#CsfAnonymousInternal()
command!  CsfLoginProd call auth#CsfLogin("https://login.salesforce.com")
command!  CsfLoginSandbox call auth#CsfLogin("https://test.salesforce.com")
command!  CsfLogout call auth#CsfLogout()
command!  CsfShowUsername echo auth#CsfGetUsername()
"}}}
