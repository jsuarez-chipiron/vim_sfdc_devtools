# vim_sfdc_devtools

TODO: refrase this paragraph
Apex PMD is a very small and simple plugin to lint PMD violations on Apex files. Currently the plugin shows the list of violation in a quickfix table on saving an apex file. 

We are working on releasing new exiting features in the near future :wink:

## installation
There are several ways to install this plugin, the easiest one is to leverage a vim pluging manager. 

### Using Vim plugin manager - Plug

Plug is a minimalist Vim plugin manager, please follow the installation intructions in this [link](https://github.com/junegunn/vim-plug)
Once the plugin is instaled you need to add following lines to your ~/.vimrc file

```
call plug#begin()
Plug 'jsuarez-chipiron/apex_pmd'
call plug#end()
```

## configuration

apex_pmd requires [PMD](https://github.com/pmd/pmd/releases/) installed in your local machine

Add following variables to your vimrc

```
let g:pmd_home=''
let g:ruleset_path=''
```
Where
pmd_home points to pmd home path
releset_path points to the ruleset_path
