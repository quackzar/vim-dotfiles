" Language: Crafttweaker

if exists("b:current_syntax")
    finish
endif

" Keywords
syn keyword ctCondition if else has in
syn keyword ctRepeat for while to
syn keyword ctKeywords as include import function return version to global static val var

syn keyword ctNull null
syn keyword ctBool true false
syn keyword ctPrimitives bool byte short int long float double string void
syn keyword ctObjectTypes IData IIngredient IItemStack ILiquidStack IOreDictEntry
syn region ctBracketHandler matchgroup=Identifier start="<" end=">" contains=ctBracketIngredient,ctBracketMod,ctBracketIngredientMeta
syn match ctBracketMod "\v[^:][a-z_]+" contained
syn match ctBracketIngredient "\v:[a-zA-Z_]+"hs=s+1 contained
syn match ctBracketIngredientMeta "\v:\d+"hs=s+1 contained

syn keyword ctGlobalFields brewing client events format furnace game itemUtils loadedMods logger oreDict loot mods recipes scripts seeds server vanilla
syn keyword ctGlobalFuncs print totalActions enableDebug isNull max min pow
syn keyword ctGeneralMethods keys keySet values valueSet entrySet length toLowerCase toUpperCase getBytes hashCode intern isEmpty toCharArray remove trim
syn keyword ctOreDictFuncs add addAll addItems empty firstItem removeItems
syn keyword ctRecipeFuncs addHidden addShaped addShapedMirrored addShapeless all craft getRecipesFor removeAll removeByRecipeName removeByRegex removeShaped removeShapeless replaceAllOccurences
syn keyword ctIngredientModifiers amount anyDamage damage giveBack items marked matches matchesExact noReturn onlyDamageAtLeast OnlyDamageAtMost OnlyDamageBetween onlyDamaged onlyStack onlyWithTag or reuse tag transformConsume transformDamage transformReplace updateTag weight withDamage withTag
syn keyword ctFurnaceFuncs getFuel setFuel 
syn keyword ctMiscFuncs addBrew addChestLoot removeChestLoot addSeed removeSeed displayName addTooltip addShiftTooltip clearTooltip setLocalisation

" Numbers
syn match ctNumber '\d\+'
syn match ctNumber '[-+]\d\+'

" Floats
syn match ctFloat '\d\+\.\d\+'
syn match ctFloat '[-+]\d\+\.\d\+'

" Strings
syn region ctString start='"' skip='\\.' end='"'
syn region ctString start="'" skip='\\.' end="'"

" Blocks
syn region ctBlock matchgroup=ctParen start='{' end='}' fold transparent
syn region ctArray matchgroup=ctParen start='\[' end='\]' fold transparent

" Comments
syn keyword ctTodo contained TODO FIXME XXX
syn keyword ctPreProc contained debug ignoreBracketErrors loader modloaded norun priority

syn region ctComment start='#' end='$' contains=ctPreProc
syn region ctComment start='//' end='$' contains=ctTodo
syn region ctComment start='/\*' end='\*/' contains=ctTodo

syn match ctOperator "\v!"
syn match ctOperator "\v\~"
syn match ctOperator "\v\*"
syn match ctOperator "\v\ /\ "
syn match ctOperator "\v\+"
syn match ctOperator "\v-"
syn match ctOperator "\v\?"
syn match ctOperator "\v\="
syn match ctOperator "\v\*\="
syn match ctOperator "\v/\="
syn match ctOperator "\v\+\="
syn match ctOperator "\v-\="
syn match ctOperator "\v\ \>\ "
syn match ctOperator "\v\ \<\ "
syn match ctOperator "\v\&"
syn match ctOperator "\v\|"
syn match ctOperator "\v\^"

hi def link ctTodo Todo
hi def link ctComment Comment
hi def link ctPreProc PreProc
hi def link ctCondition Conditional
hi def link ctRepeat Repeat
hi def link ctKeywords Keyword
hi def link ctOperator Operator

hi def link ctNull Boolean
hi def link ctBool Boolean
hi def link ctFloat Number
hi def link ctNumber Number
hi def link ctString String
hi def link ctPrimitives Type
hi def link ctObjectTypes Type
hi def link ctBracketHandler Float
hi def link ctBracketIngredient Label
hi def link ctBracketIngredientMeta Number

hi def link ctGlobalFields Keyword
hi def link ctGlobalFuncs Keyword

hi def link ctGeneralMethods Function
hi def link ctOreDictFuncs Function
hi def link ctRecipeFuncs Function
hi def link ctIngredientModifiers Operator
hi def link ctFurnaceFuncs Function
hi def link ctMiscFuncs Function

let b:current_syntax = "crafttweaker"

