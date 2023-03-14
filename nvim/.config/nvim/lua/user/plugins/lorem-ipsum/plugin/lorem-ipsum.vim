" Title:        Lorem Ipsum
" Description:  A plugin to generate lorem ipsum text in different language
" Last Change:  25 January 2023
" Maintainer:   Fritiof Rusck <https://github.com/pumpedsardines>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_pumpedsardines_loremipsum")
    finish
endif
let g:loaded_pumpedsardines_loremipsum = 1

" Defines a package path for Lua. This facilitates importing the
" Lua modules from the plugin's dependency directory.
let s:lua_rocks_deps_loc =  expand("<sfile>:h:r") . "/../lua/lorem-ipsum/deps"
exe "lua package.path = package.path .. ';" . s:lua_rocks_deps_loc . "/lua-?/init.lua'"

" Exposes the plugin's functions for use as commands in Neovim.
command! -nargs=? LoremIpsum lua require("lorem-ipsum").write_lorem_ipsum(<f-args>)
