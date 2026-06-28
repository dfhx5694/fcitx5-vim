vim9script
# fcitx5-vim [MIT]
# GetLatestVimScripts: 6182 1 :AutoInstall: fcitx5-vim.vim

if get(g:, 'loaded_fcitx5_vim', false) | finish | endif
g:loaded_fcitx5_vim = true


var fcitx_cmd = get(g:, 'fcitx5_remote_cmd', 'fcitx5-remote')
if !executable(fcitx_cmd) | finish | endif

var fcitx_im = get(g:, 'fcitx5_im', '')
if fcitx_im == ''
	echohl ErrorMsg | echom "[fcitx5-vim] Please set g:fcitx5_im" | echohl NONE
	finish
endif

def ResetIm()
	job_start([fcitx_cmd, '-s', fcitx_im])
enddef

augroup Fcitx5
	autocmd!
	autocmd VimEnter * ResetIm()
	autocmd FocusGained * ResetIm()
	autocmd CmdlineLeave * if reg_executing() == '' | ResetIm() | endif
	autocmd ModeChanged *:[^irv]* if reg_executing() == '' | ResetIm() | endif
augroup END
