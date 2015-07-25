" Insert `help you to quote a good phrase!`.
" Last Change:  2015-07-25
" Maintainer:   Shinya Ohyanagi <sohyanagi@gmail.com>
" License:      NEW BSD
" NOTE:         This is a Vim plugin for https://github.com/konifar/kotoha
let s:save_cpo = &cpo
set cpo&vim

command! -nargs=* -range=0 -complete=customlist,kotoha#complete_cmd KotohaQuery
  \ call kotoha#search_query(<q-args>, <count>, <line1>, <line2>)

command! -nargs=* -range=0 -complete=customlist,kotoha#complete_cmd KotohaTag
  \ call kotoha#search_tag(<q-args>, <count>, <line1>, <line2>)

let &cpo = s:save_cpo
unlet s:save_cpo

