; extends
(
 (line_comment) @_first
 (_) @rust
 (line_comment) @_last
 (#match? @_first "^/// ```$")
 (#match? @_last "^/// ```$")
 (#offset! @rust 0 4 0 4)
)

; This extends the documentation with rust syntax highlighting in code blocks
; However it has a HUGE performance impact, and slows insert-mode to a halt.
