if has('cscope')
	set cscopetag cscopeverbose

	if has('quickfix')
		" set cscopequickfix=s-,c-,d-,i-,t-,e-
	endif

"cnoreabbrev csa cs add
"cnoreabbrev csf cs find
"cnoreabbrev csk cs kill
"cnoreabbrev csr cs reset
"cnoreabbrev css cs show
"cnoreabbrev csh cs help

	" Fix whitespace on saving
	autocmd BufWritePre * :%s/\s\+$//e

	set tabstop=4
	set shiftwidth=4
	set list listchars=tab:\>\ ,trail:-

	" More info here: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
	" Show tabs that are not at the start of a line:
	" Show spaces used for indenting (so you use only tabs for indenting).
	highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
	match ExtraWhitespace /^[^/].*[^\t]\zs\t\+\|^\t*\zs \+[^\*]/

	command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif