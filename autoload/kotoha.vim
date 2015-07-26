" Insert `help you to quote a good phrase!`.
" Last Change:  2015-07-25
" Maintainer:   Shinya Ohyanagi <sohyanagi@gmail.com>
" License:      NEW BSD
" NOTE:         This is a Vim plugin for https://github.com/konifar/kotoha
let s:save_cpo = &cpo
set cpo&vim

let s:root_url = 'https://kotoha-server.herokuapp.com/api/phrases.json'
let s:phrases = []

let s:kotoha_params = ['query']

function! kotoha#complete_cmd(lead, cmd, pos)
  let args = map(copy(s:kotoha_params), '"-" . v:val . "="')
  return filter(args, 'v:val =~# "^".a:lead')
endfunction

function! kotoha#search_tag(...)
  call s:get(a:000[0], 't')
  call s:run()
endfunction

function! kotoha#search_query(...)
  call s:get(a:000[0], 'k')
  call s:run()
endfunction

function! s:run()
  if &omnifunc == ''
    set omnifunc=kotoha#complete
  endif

  call feedkeys("i")
  call feedkeys("\<C-X>\<C-O>\<C-P>", 'n')
endfunction

function! kotoha#complete(findstart, base)
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  endif

  let res = []
  for p in s:phrases
    if p =~ '^' . a:base
      call add(res, p)
    endif
  endfor
  return res
endfunction

function! s:build_query(args)
  let querys = split(a:args, '=')

  if len(querys) > 1
    return querys[1]
  endif

  return ''
endfunction

function! s:get(query, kind)
  "let query = webapi#http#encodeURI(s:build_query(a:query))
  let query = s:build_query(a:query)
  let params = {}

  if a:kind == 'k'
    let params = {'text': query}
  elseif a:kind == 't'
    let params = {'tag': query}
  endif

  let response = webapi#http#get(s:root_url, params)
  let content = webapi#json#decode(response.content)

  let phrases = []
  for c in content
    call add(phrases, c.text)
  endfor
  " XXX Append?
  let s:phrases = phrases

  return content
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
