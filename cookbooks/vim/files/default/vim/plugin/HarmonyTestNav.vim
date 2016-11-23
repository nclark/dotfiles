function! s:add_spec_directory(path)
    return substitute(a:path, 'harmony\/', 'harmony\/spec\/', '')
endfunction

function! s:add_spec_prefix(path)
	return substitute(a:path, '\.rb', '_spec.rb', '')
endfunction

" public functions

function! g:EditPairFile(open_style)
    let l:current_file = expand('%:p')
    let l:file_with_spec_dir = s:add_spec_directory(l:current_file)
    let l:spec_file = s:add_spec_prefix(l:file_with_spec_dir)

    if l:spec_file != l:current_file && filereadable(l:spec_file)
        execute a:open_style . " " . l:spec_file
    else
        echom "could not find matching spec: " . l:spec_file
    endif
endfunction

command! AG call g:EditPairFile('edit')
command! AT call g:EditPairFile('tabedit')
command! AS call g:EditPairFile('rightbelow split')
command! AV call g:EditPairFile('rightbelow vsplit')

