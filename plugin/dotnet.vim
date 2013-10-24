if exists('loaded_dotnet')
    finish
endif

if !exists('g:dotnet_map_keys')
    let g:dotnet_map_keys = 1
endif

if !exists('g:dotnet_map_prefix')
    let g:dotnet_map_prefix = '<leader>'
endif

if g:dotnet_map_keys
    " map <leader>b to :make, triggering the csharp compiler
    execute "autocmd FileType cs" "nnoremap <buffer>" g:dotnet_map_prefix."b" ":make<cr>"
    " also map F5 to execute the build
    execute "autocmd FileType cs" "nnoremap <buffer>" "<F5>" ":make<cr>"
endif

" Automatically use devenv compiler when working in csharp files
if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    autocmd BufNewFile,BufRead *.cs compiler devenv
endif

