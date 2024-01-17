" Vim syntax file
" Language:	ADL (Archetype Description Language)
" Maintainer:	Thomas Beale (thomas.beale@openEHR.org)
" URL:		https://openehr.atlassian.net/wiki/display/dev/ADL+Text+Editors
" Last change:	2015 jun 10

" Remove any old syntax stuff hanging around
syn clear

" keyword definitions
syn keyword adlTopStruct archetype template template_overlay operational_template
syn keyword adlTopStruct concept specialise specialize
syn keyword adlBuiltIn  matches
syn keyword adlBuiltIn  existence cardinality occurrences
syn keyword adlBuiltIn  allow_archetype use_archetype use_node
syn keyword adlBuiltIn  unordered ordered unique non-unique

" Operators
syn keyword adlOperator  xor or implies not exists and else for_all

"catch errors caused by wrong parenthesis and brackets
syn cluster	adlParenGroup	contains=adlParenError
if exists("adl_no_bracket_error")
  syn region	adlParen		transparent start='(' end=')' contains=ALLBUT,@adlParenGroup
  syn match	adlParenError	")"
  syn match	adlErrInParen	contained "[{}]"
else
  syn region	adlParen		transparent start='(' end=')' contains=ALLBUT,@adlParenGroup,adlErrInBracket
  syn match	adlParenError	"[\])]"
  syn match	adlErrInParen	contained "[\]{}]"
  syn match	adlErrInBracket	contained "[)]"
endif

" ODIN keys: ["word dashes allowed"]
syn match   odinKey	"\[\"\w\+\([-.]\w\+\)*\"\]"

" ADL coded terms
" Archetype internal id/ac/at coded terms
syn match   adlCoded          "\[\(at\|ac\|id\|gt\)\d\+\(\.\d\+\)*\]"
" External coded terms matching any of 
"  [code_string]
"  [terminology_id::code_string]
"  [terminology_id(version_id)::code_string]
syn match   adlCoded          "\[\(\w\+\(-\w\+\)*\((\w\+\(\.\w\+\)*)\)\=::\)\=\w[^"\]}+ ]*\]"

" identifiers
syn keyword adlTodo           contained TODO XXX FIXME
syn match   adlClassName      "\<\u\w\+\>"
syn match   adlPropertyName   "\<\l\w\+\>"
syn match   adlPropertyTuple  "\[\l\w\+\(\s*,\s*\l\w\+\)\+\]"

" keywords if they appear at start of line
syn match adlTopStruct "^\(description\|language\|definition\|terminology\|ontology\|annotations\|rules\)"

" Strings and constants
syn keyword adlBool          true false
syn keyword adlBool		True False
" skip escaped characters and newlines
syn region  adlString         start=+"+ skip=+\(\\.\|\r\)+ end=+"+

" hexadecimal numbers
syn match	adlSpecial	contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"	
" unicode numbers
syn match	adlSpecial	contained "\\\(u\x\{4}\|U\x\{8}\)"
" other escaped codes
syn match	adlCharacter	"'[^\\]'"
syn match	adlCharacter	"'[^']*'" contains=adlSpecial
syn match	adlSpecialError	"'\\[^'\"?\\abfnrtv]'"
syn match	adlSpecialCharacter "'\\['\"?\\abfnrtv]'"
syn match	adlSpecialCharacter "'\\\o\{1,3}'"
syn match	adlSpecialCharacter "'\\x\x\{1,2}'"
syn match	adlSpecialCharacter "'\\x\x\+'"

" numbers
syn match   adlNumber         "-\=\<\d\+\(_\d\+\)*\>"
syn match   adlNumber         "\<[01]\+[bB]\>"
syn match   adlNumber         "-\=\<\d\+\(_\d\+\)*\.\(\d\+\(_\d\+\)*\)\=\([eE][-+]\=\d\+\(_\d\+\)*\)\="
syn match   adlNumber         "-\=\.\d\+\(_\d\+\)*\([eE][-+]\=\d\+\(_\d\+\)*\)\="

" comments
syn match   adlComment        "--.*"


" Colour mappings
if !exists("did_adl_syntax_inits")
  let did_adl_syntax_inits = 1
  " The default methods for highlighting.  Can be overridden later
  hi link adlTopStruct	Section
  hi link adlStatement    Statement
  hi link adlBool	  Boolean
  hi link adlString	Value
  hi link adlCharacter	Character

  hi link adlClassName	Type
  hi link adlPropertyName	TypeAttr
  hi link adlPropertyTuple	TypeAttr
  hi link odinKey	TypeAttrKey
  hi link adlNumber		Number
  hi link adlBuiltIn		Keyword

  hi link adlSpecialError	adlError
  hi link adlParenError	adlError
  hi link adlErrInParen	adlError
  hi link adlErrInBracket	adlError
  hi link adlError	Error

  hi link adlCoded	Coded

  hi link adlOperator	Special
  hi link adlBracket	Coded
  hi link adlComment	Comment

  hi link adlSpecialCharacter	adlSpecial
  hi link adlSpecial	SpecialChar
endif

let b:current_syntax = "adl"

" vim: ts=8
