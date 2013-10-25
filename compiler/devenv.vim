" Vim compiler file
" Compiler: DevEnv/MSBuild

if exists("current_compiler")
    finish
endif
let current_compiler = "devenv"

" Absolute path of script file:
let s:compiler_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" Absolute path of the current cs file
let s:file_path = expand('%:p:h')

let s:solution_files = []
let s:parent_path = s:file_path

" TODO: handle case where no solution file is found up the tree
while len(s:solution_files) < 1
    " Determine parent directory
    let s:parent_path = fnamemodify(s:parent_path, ':h')
    " Find sln files in parent directory
    let s:solution_files = split(globpath(s:parent_path, '*.sln'), '\n')
endwhile

" TODO: allow to override build command from a .vimdotnet file
if !exists('g:dotnet_build_command')
    let g:dotnet_build_command = s:compiler_path.'\build.bat "'.s:solution_files[0].'"'
endif

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
    command -nargs=* CompilerSet setlocal <args>
endif

" default errorformat
CompilerSet errorformat=\ %#%f(%l\\\,%c):\ %m

" default make
let &makeprg = g:dotnet_build_command

