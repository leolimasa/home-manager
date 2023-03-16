#lang racket

(define (bash cmd)
  (define-values (p stdout stdin stderr) (subprocess #f #f #f "/usr/bin/env" "bash" "-c" cmd))
  (values stdout stdin stderr))

(define (bash-lines cmd)
  (define-values (stdout stdin stderr) (bash cmd))
  (in-lines stdout))

(define (bash-list cmd)
  (sequence->list (bash-lines cmd)))

(define (fg color)
  (match color
         ['black 30]
         ['red 31]
         ['green 32]
         ['yellow 33]
         ['blue 34]
         ['magenta 35]
         ['cyan 36]
         ['light-gray 37]
         ['gray 90]
         ['light-red 91]
         ['light-green 92]
         ['light-yellow 93]
         ['light-blue 94]
         ['light-magenta 95]
         ['light-cyan 96]
         ['white 97]
  ))

(define (bg color)
  (match color
         ['black 40]
         ['red 41]
         ['green 42]
         ['yellow 43]
         ['blue 44]
         ['magenta 45]
         ['cyan 46]
         ['light-gray 47]
         ['gray 100]
         ['light-red 101]
         ['light-green 102]
         ['light-yellow 103]
         ['light-blue 104]
         ['light-magenta 105]
         ['light-cyan 106]
         ['white 107]))

(define (decoration deco)
  (match deco 
          ['reset 0]
          ['bold 1]
          ['faint 2]
          ['italics 3]
          ['underline 4]))

(define (fmt options content)
  (string-append 
    "\e["
    (string-join (map number->string options) ";")
    "m"
    content
    "\e["
    (number->string (decoration 'reset))
    "m"))
    

(define (enumerate-list lst)
  (define bold-blue (list (fg 'blue) (decoration 'bold)))
  (map 
    (lambda (num item) 
      (string-append 
        (fmt bold-blue (string-append (number->string num) ") " ))
        item)) 
    (range 0 (length lst))
    lst))

(provide 
  bash
  bash-list
  bash-lines
  bg
  fg
  decoration
  fmt
  enumerate-list)
