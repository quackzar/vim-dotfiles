if exists('g:no_vim_conceal') || !has('conceal') || &enc != 'utf-8'
  finish
endif

" comparators
syntax match jsOperator "<=" conceal cchar=≤
syntax match jsOperator ">=" conceal cchar=≥
syntax match jsOperator "!==" conceal cchar=≢
syntax match jsOperator "<<<" conceal cchar=⋘
syntax match jsOperator "&&" conceal cchar=∧
syntax match jsOperator "||" conceal cchar=∨
syntax match jsOperator "++" conceal cchar=Δ
syntax match jsOperator "+=" conceal cchar=Δ
syntax match jsOperator "--" conceal cchar=∇
syntax match jsOperator "-=" conceal cchar=∇

" arrow functions
syntax match jsArrowFunction /=>/ conceal cchar=⇒

" keywords
syntax keyword jsNull null conceal cchar=∅
syntax keyword jsBooleanTrue true conceal cchar=⊤
syntax keyword jsBooleanFalse false conceal cchar=⊥
syntax keyword jsConditional if conceal cchar=▸
syntax keyword jsConditional else conceal cchar=▪
syntax keyword jsRepeat for conceal cchar=∀
syntax keyword jsRepeat while conceal cchar=∀
syntax keyword jsOperator in conceal cchar=∈
syntax keyword jsOperator of conceal cchar=∋
syntax keyword jsReturn return conceal cchar=⤺
syntax keyword jsThis this conceal cchar=⟐
syntax keyword jsStatement function conceal cchar=∫
syntax keyword jsStorageClass const var let conceal cchar=፨

" ∿

hi link jsOperator Operator
hi link jsStatement Statement
hi link jsKeyword Keyword
hi link jsNull Special
hi link jsBooleanTrue Type
hi link jsBooleanFalse Type

hi! link Conceal Operator
hi! link Conceal StorageClass
hi! link Conceal Statement
"hi! link Conceal Special
"hi! link Conceal Type
"hi! link Conceal Boolean
"hi! link Conceal Conditional

setlocal conceallevel=1
