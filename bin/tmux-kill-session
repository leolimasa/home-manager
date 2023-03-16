#!/usr/bin/env racket
#lang racket

(require "rkt/bash.rkt")

(define (session-name sessions idx)
  (define line (list-ref sessions idx))
  (list-ref (string-split line ":") 0))

(define (kill-session sessions idx)
  (define session (session-name sessions idx))
  (bash (string-append "tmux kill-session -t " session)))

(define (main)
  (define sessions (bash-list "tmux list-sessions"))
  (define bold (list (decoration 'bold)))
  (display (string-join (enumerate-list sessions) "\n"))
  (display "\n")
  (display (fmt bold "\nSelect session number to kill: "))
  (define idx (string->number (read-line (current-input-port) 'any)))
  (kill-session sessions idx))

(main)
