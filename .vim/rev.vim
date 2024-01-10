"Vim syntax taken from https://dimap.ufrn.br/~rafaelbg/vim.html 
syn match revComentario "'.*$"
syn match revCorrecao   "-.*$"
syn match revLido       "%.*$"
syn match revSecao      "[0-9].*$"

let b:current_syntax = "rev"

hi def link revComentario       Todo
hi def link revCorrecao         Comment
hi def link revLido             Statement
hi def link revSecao            Constant
