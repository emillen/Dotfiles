local cmd = vim.cmd

cmd([[
    augroup vimrc-sync-fromstart
      autocmd!
      autocmd BufEnter * :syntax sync maxlines=200
    augroup END
]])

-- make/cmake
cmd([[
    augroup vimrc-make-cmake
      autocmd!
      autocmd FileType make setlocal noexpandtab
      autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
    augroup END
]])

-- golang
cmd([[
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
]])

cmd([[
    augroup completion_preview_close
      autocmd! 
      if v:version > 703 || v:version == 703 && has("patch598")
        autocmd CompleteDone * if !&previewwindow && &completeopt =~ "preview" | silent! pclose | endif
      endif
    augroup END
]])

-- html
-- for html files, 2 spaces
cmd([[ 
    augroup vimrc-html
      autocmd!
        autocmd Filetype html setlocal ts=2 sw=2 expandtab 
    augroup END
]])

-- vim-javascript
cmd([[
    augroup vimrc-javascript
      autocmd!
      autocmd FileType javascript setl tabstop=2|setl shiftwidth=2|setl expandtab softtabstop=2
    augroup END
]])
-- vim-svelte

cmd([[
    augroup vimrc-svelte
      autocmd!
      autocmd FileType svelte setl tabstop=2|setl shiftwidth=2|setl expandtab softtabstop=2
    augroup END
]])

-- typescript
cmd([[
    augroup vimrc-typescript
      autocmd!
      autocmd FileType typescript setl tabstop=2|setl shiftwidth=2|setl expandtab softtabstop=2
    augroup END
]])

-- set bats-files as shell files
cmd([[
    augroup bats
      au!
      autocmd BufNewFile,BufRead *bats   set filetype=sh
    augroup END
]])

-- ansible
cmd([[
    augroup vimrc-ansible
      autocmd!
      autocmd BufNewFile,BufRead hosts setfiletype yaml.ansible
      autocmd BufRead,BufNewFile */molecule/*.yml set filetype=yaml.ansible
      autocmd BufRead,BufNewFile */tasks/*.yml set filetype=yaml.ansible
      autocmd BufRead,BufNewFile */tasks/*.yaml set filetype=yaml.ansible
      autocmd BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
      autocmd BufRead,BufNewFile */playbooks/*.yaml set filetype=yaml.ansible
      autocmd BufRead,BufNewFile */roles/*.yml set filetype=yaml.ansible
      autocmd BufRead,BufNewFile */roles/*.yaml set filetype=yaml.ansible
    augroup END
]])

-- vim-yaml
cmd([[
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
]])

-- python
-- vim-python
cmd([[
    augroup vimrc-python
      autocmd!
      autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
          \ formatoptions+=croq softtabstop=4
          \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
    augroup END
]])
