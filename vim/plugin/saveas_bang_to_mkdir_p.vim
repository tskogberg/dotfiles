" ':SaveAs foo/bar.txt' without any exclamation marks works just like ':saveas'.
" ':SaveAs! foo/bar.txt' with an initial bang works just like ':saveas!'.
" ':SaveAs foo/bar.txt!' with a trailing bang creates directories if they don't exist.
"
" By Henrik Nyh <http://henrik.nyh.se> under the MIT license.

command! -nargs=1 -complete=file -bang SaveAs :call SaveAs(<f-args>, '<bang>')

function! SaveAs(filename, bang)
  if a:filename =~ "!$"
    let l:filename = substitute(a:filename, "!$", "", "")
    let l:dir = fnamemodify(l:filename, ":p:h")
    if !isdirectory(l:dir)
      call mkdir(l:dir, "p")
    end
  else
    let l:filename = a:filename
  endif
  exe "saveas" . a:bang . " " . l:filename
endfunction


" http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev

function! s:CommandCabbr(abbreviation, expansion)
  execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

command! -nargs=+ CommandCabbr call <SID>CommandCabbr(<f-args>)

" :saveas calls :SaveAs
CommandCabbr saveas SaveAs
