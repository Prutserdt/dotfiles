;;; init.el -*- lexical-binding: t; -*-

;; NOTE: This file is generated from ~/.doom.d/README.org
;;      Please only edit that file and org-babel-tangle (emacs)

(doom! :completion
       company             ; the ultimate code completion backend
       vertico             ; the search engine of the future
       (ivy +childframe)   ; a search engine for love and life

       :ui
       doom                ; what makes DOOM look the way it does
       doom-dashboard      ; a nifty splash screen for Emacs
       (emoji +unicode)    ; ð
       hl-todo             ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       modeline            ; snazzy, Atom-inspired modeline, plus API
       ophints             ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
;;     vc-gutter           ; vcs diff in the fringe
       vi-tilde-fringe     ; fringe tildes to mark beyond EOB
       workspaces          ; tab emulation, persistence & separate workspaces
;;     treemacs            ; a project drawer, like neotree but cooler

       :editor
       (evil +everywhere)  ; come to the dark side, we have cookies
       file-templates      ; auto-snippets for empty files
       fold                ; (nigh) universal code folding
       snippets            ; my elves. They type so I don't have to

       :emacs
       (dired +icons)      ; making dired pretty [functional]
       electric            ; smarter, keyword-based electric-indent
       undo                ; persistent, smarter undo for your inevitable mistakes
       vc                  ; version-control and :Emacs, sitting in a tree

       :term
       vterm               ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
;;     spell               ; spelling checker, used it briefly. Can be used manually by running
                           ; ispell-buffer, which suits my needs better

       :tools
       debugger            ; stepping through code, to help you add bugs
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       lsp                 ; M-x vscode
;;     magit               ; a git porcelain for Emacs

       :lang
       emacs-lisp          ; drown in parentheses
;;     markdown            ; writing docs for people to ignore
       (org +pretty +roam2); organize your plain life in plain text
       (python +lsp)       ; beautiful is better than ugly
                           ; +pyright. Tried pyright, could not get it to work on all of my machines
       sh                  ; she sells {ba,z,fi}sh shells on the C xor
;;     php                 ; perl's insecure younger brother
;;     latex

       :os
       tty                 ; ?test, zou terminal experience moeten verbeteren,
                           ;kijken of dit een verbetering geeft..

       :config
       (default +bindings +smartparens)
       )
