" Promote variable to RSpec let.
" Based on
" https://github.com/myronmarston/vim_files/commit/ed60919f1857359da617491a7d7c14e8d4befae0
"
" Given either of
"
"   foo = x
"   @foo = x
"
" on the current line or in a given range (e.g. visual range),
" this command moves the assignments out to an RSpec let:
"
"   let(:foo) { x }
"
function! s:PromoteToLet()
  let current_line = getline('.')
  let equals = '@\?\w\+ = .*$'
  let let = 'let(:\w\+)\s{\s.*\s}$'

  if current_line =~ equals
    .s/@\?\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  elseif current_line =~ let
    .s/let(:\(\w\+\))\s{\s\(.*\)\s}$/\1 = \2/
  else
    echom 'no match'
  endif
endfunction

command! -range Let execute '<line1>,<line2>call <SID>PromoteToLet()'
